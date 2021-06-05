#include <atmel_start.h>
#include <util/delay.h>
#include <stdio.h>
#include "main.h"
#include "twihelper.h"

typedef enum {IDLE, START, RUN, STOP, WAIT, OFF} pump_mode_t;
const char *pump_mode_names[] = {"IDLE", "START", "RUN", "STOP", "WAIT", "OFF"};
	
pump_mode_t pump_mode = IDLE;
pump_mode_t pump_mode_next = IDLE;

uint8_t tempMax = 0;
uint8_t tempMaxLast = 0;

uint8_t btn_now_debounce = 0xFF;
uint8_t btn_now_state = true;

uint8_t btn_wait_debounce = 0xFF;
uint8_t btn_wait_state = true;

uint16_t eeprom_index = 0;

volatile uint8_t pump_remaining = 0;

volatile uint8_t humidity_alarm = false;

volatile uint8_t t_hour = 0;
volatile uint8_t t_minute = 0;
volatile uint8_t t_second = 0;

volatile uint8_t triggerRTC = false;
volatile uint8_t triggerHTU = true;
volatile uint8_t triggerMidnight = false;

// ---------------------------------------------- ISR

ISR(TIMER1_COMPA_vect) {
	t_second++;
	if (t_second > 59) {
		t_second = 0;
		t_minute++;
		if (t_minute > 59) {
			t_minute = 0;
			t_hour++;
			if (t_hour > 23) {
				t_hour = 0;
			}
		}
	}	

	if (t_hour == 0 && t_minute == 0 && t_second == 0) {
		triggerMidnight = true;		
	}
	if (t_hour == 4 && t_minute == 0 && t_second == 0) {
		triggerRTC = true;
	}
	if (t_second == 30) {
		triggerHTU = true;
	}

	if (pump_remaining > 0) {
		pump_remaining--;
	}
	
	if (pump_mode == RUN && pump_remaining == 0) {
		pump_mode_next = STOP;
	}
	
	if (humidity_alarm) {
		BTN_NOW_LED_set_level(t_second % 2 == 0);
		BTN_WAIT_LED_set_level(t_second % 2 != 0);
	} else {
		if (pump_mode == RUN) {
			BTN_NOW_LED_set_level(t_second % 2 == 0);
		}
		if (pump_mode == WAIT) {
			BTN_WAIT_LED_set_level(t_second % 2 == 0);
		}
		if (pump_mode == OFF) {
			BTN_WAIT_LED_set_level(t_second % 4 == 0);
		}	
	}
		
	if (t_minute == 0 && t_second == 0 && pump_mode == IDLE) {
		if (tempMax <= 22					&& ( t_hour == 15 ) ) {
			pump_mode_next = START;			
		}
		if (tempMax > 22 && tempMax <=26	&& ( t_hour == 15 || t_hour == 21) ) {
			pump_mode_next = START;
		}		
		if (tempMax > 26 && tempMax <=30	&& ( t_hour == 15 || t_hour == 18 || t_hour == 21 ) ) {			
			pump_mode_next = START;
		}		
		if (tempMax > 30					&& ( t_hour == 15 || t_hour == 18 || t_hour == 21 ) ) {
			pump_mode_next = START;
		}
		
		if (tempMaxLast > 30				&& ( t_hour == 9 ) ) {
			pump_mode_next = START;	
		}
	}
}

// ---------------------------------------------- Buttons

void btnNow() {
	printf("Button: NOW\n");
	switch (pump_mode) {
		case IDLE:
			pump_mode_next = START;
			break;
		case START:
			break;
		case RUN:
			break;
		case STOP:
			break;
		case WAIT:
			pump_mode_next = IDLE;
			break;
		case OFF:
			pump_mode_next = WAIT;
			break;
	}
}

void btnWait() {
	printf("Button: WAIT\n");
	switch (pump_mode) {
		case IDLE:
			pump_mode_next = WAIT;
			break;
		case START:
			pump_mode_next = STOP;
			break;
		case RUN:
			pump_mode_next = STOP;
			break;
		case STOP:
			pump_mode_next = WAIT;
			break;
		case WAIT:
			pump_mode_next = OFF;			
			break;
		case OFF:		
			break;
	}	
}

// ---------------------------------------------- HTU21

uint16_t readHTU21(uint8_t cmd) {
	uint16_t rawValue = 0;
	
	TWIStart();
	if (TWIGetStatus() != 0x08)	return 1;
	
	TWIWrite(0x80);
	if (TWIGetStatus() != 0x18)	return 2;
	
	TWIWrite(cmd);
	if (TWIGetStatus() != 0x28) return 3;
	
	TWIStart();
	if (TWIGetStatus() != 0x10)	return 4;
	
	TWIWrite(0x81);
	if (TWIGetStatus() != 0x40)	return 5;
	
	rawValue = (uint16_t)TWIReadACK() << 8;
	if (TWIGetStatus() != 0x50)	return 6;
	
	rawValue |= TWIReadACK();
	if (TWIGetStatus() != 0x50)	return 7;

	TWIReadNACK();
	if (TWIGetStatus() != 0x58)	return 8;
	
	TWIStop();

	rawValue &= ~(0x03);
	
	return rawValue;
}

uint16_t readTemperature() {
	uint16_t rawValue = readHTU21(0xE3);		
	float temperature = -46.85 + 175.72 * (float) rawValue / (float) ((uint32_t)1 << 16);
	if (temperature < 0) {
		temperature = 0;
	}
	return (uint8_t) temperature;
}

uint8_t readHumidity() {
	uint16_t rawValue = readHTU21(0xE3);
	float humidity = -6.0 + 125.0 * (float) rawValue / (float) ((uint32_t)1 << 16);
	if (humidity < 0) {
		humidity = 0;
	}
	return (uint8_t)humidity;
}

// ---------------------------------------------- DS3231

uint8_t writeDS3231(uint8_t cmd, uint8_t data) {
	TWIStart();
	if (TWIGetStatus() != 0x08)	return 1;
	
	TWIWrite(0xD0);
	if (TWIGetStatus() != 0x18)	return 2;

	TWIWrite(cmd);
	if (TWIGetStatus() != 0x28)	return 3;

	TWIWrite(data);
	if (TWIGetStatus() != 0x28)	return 4;
	
	TWIStop();
	
	return 0;
}

void setDS3231() {
	int hour, minute, second;
	printf("Compile Time: %s\n", __TIME__);
	sscanf(__TIME__, "%d:%d:%d", &hour, &minute, &second);

	second += SETRTC_OFFSET;
	if (second > 59) {
		second = 0;
		minute++;
		if (minute > 59) {
			minute = 0;
			hour++;
			if (hour > 23) {
				hour = 0;
			}
		}
	}
	printf("Setting RTC to %02d:%02d:%02d\n", hour, minute, second);
	printf("Setting Second: %d\n", writeDS3231(0x00, (second/10*16) + (second%10) ));
	printf("Setting Minute: %d\n", writeDS3231(0x01, (minute/10*16) + (minute%10) ));
	printf("Setting Hour: %d\n", writeDS3231(0x02, (hour/10*16) + (hour%10) ));
}

uint8_t readDS3231(uint8_t cmd) {
	uint8_t rawValue = 0;
	
	TWIStart();
	if (TWIGetStatus() != 0x08)	return 1;
	
	TWIWrite(0xD0);
	if (TWIGetStatus() != 0x18)	return 2;

	TWIWrite(cmd);
	if (TWIGetStatus() != 0x28)	return 3;
	
	TWIStart();
	
	TWIWrite(0xD1);
	if (TWIGetStatus() != 0x40) return 4;
	
	rawValue = (uint16_t)TWIReadNACK();
	if (TWIGetStatus() != 0x58)	return 5;

	TWIStop();
	
	return rawValue;
}

void syncRTC() {
	printf("RTC Update\n");
	printf("Time: %02d:%02d:%02d\n", t_hour, t_minute, t_second);

	uint8_t secRaw = readDS3231(0x00);
	uint8_t secValue = (secRaw >> 4) * 10 + (secRaw & 0b00001111);

	uint8_t minRaw = readDS3231(0x01);
	uint8_t minValue = (minRaw >> 4) * 10 + (minRaw & 0b00001111);

	uint8_t hrsRaw = readDS3231(0x02);
	uint8_t hrsValue = ((hrsRaw & 0b00110000) >> 4) * 10 + (hrsRaw & 0b00001111);

	t_second = secValue;
	t_minute = minValue;
	t_hour = hrsValue;

	printf("RTC : %02d:%02d:%02d\n", hrsValue, minValue, secValue);
}

// ---------------------------------------------- EEPROM

void eepromWipe() {
	printf("Clearing EEPROM ...");
	for (uint16_t i = 0; i < 0x3FF; i++) {
		FLASH_0_write_eeprom_byte(i, 0);
	}
	
	FLASH_0_write_eeprom_byte(0x3FE, 0);
	FLASH_0_write_eeprom_byte(0x3FF, 0);	
	printf(" done\n");
}

void eepromInit() {
	eeprom_index = (FLASH_0_read_eeprom_byte(0x3FE) << 8) + FLASH_0_read_eeprom_byte(0x3FF);
	printf("EEPROM Index: %d\n", eeprom_index);	
}

void eepromUpdate(uint8_t data) {
	FLASH_0_write_eeprom_byte(eeprom_index, data);
	eeprom_index++;
	if (eeprom_index >= 0x3FE) {
		eeprom_index = 0;
	}
	FLASH_0_write_eeprom_byte(0x3FE, eeprom_index >> 8);
	FLASH_0_write_eeprom_byte(0x3FF, eeprom_index);
	
	printf("EEPROM new index: %d\n", eeprom_index);
}

void eepromDump() {
	printf("EEPROM History: ");	
	
	for (uint16_t i = eeprom_index; i > 0; i--) {
		printf("%dC ", FLASH_0_read_eeprom_byte(i));
	
	}	
	for (uint16_t i = 0x3FD; i > eeprom_index; i--) {
		printf("%dC ", FLASH_0_read_eeprom_byte(i));
	}
	printf("\n");
}

// ---------------------------------------------- MAIN

int main(void) {
	
	atmel_start_init();
	
	sei();
	
	printf("\nhttps://github.com/kiu/gtimer v0.1\n\n");
		
	#if SETRTC
		setDS3231();
	#endif
	
	syncRTC();
	
	#if SETEEPROM
		eepromWipe();
	#endif
	
	eepromInit();
			
	BTN_NOW_LED_set_level(true);
	BTN_WAIT_LED_set_level(true);
	
	while(1) {
		
		if (triggerRTC) {
			triggerRTC = false;
			
			syncRTC();
		}
		
		if (triggerHTU) {
			triggerHTU = false;
			

			uint8_t value;

			value = readTemperature();
			if (value > tempMax) {
				tempMax = value;
			}
			printf("Temperature: %dC (Max: %dC MaxLast: %dC)\n", value, tempMax, tempMaxLast);

			value = readHumidity();
			printf("Humidity: %d%%\n", value);
			if (value > HUMIDITY_ALARM_THRESHOLD) {
				humidity_alarm = true;				
				pump_mode_next = STOP;
			}
		}
		
		if (triggerMidnight) {
			triggerMidnight = false;
			
			tempMaxLast = tempMax;
			tempMax = 0;
			if (pump_mode == WAIT) {
				pump_mode_next = IDLE;
			}
			
			eepromUpdate(tempMaxLast);
		}
		
		btn_now_debounce = (btn_now_debounce << 1) + BTN_NOW_get_level();
		if (btn_now_state && btn_now_debounce == 0x00) {
			btn_now_state = false;
			btnNow();
		}
		if (!btn_now_state && btn_now_debounce == 0xFF) {
			btn_now_state = true;			
		}

		btn_wait_debounce = (btn_wait_debounce << 1) + BTN_WAIT_get_level();
		if (btn_wait_state && btn_wait_debounce == 0x00) {
			btn_wait_state = false;
			btnWait();
		}
		if (!btn_wait_state && btn_wait_debounce == 0xFF) {
			btn_wait_state = true;
		}
		
		if (pump_mode != pump_mode_next) {
			printf("Pump mode change from %s to %s\n", pump_mode_names[pump_mode], pump_mode_names[pump_mode_next]);
			pump_mode = pump_mode_next;
			
			switch (pump_mode) {
				case IDLE:
					BTN_NOW_LED_set_level(true);
					BTN_WAIT_LED_set_level(true);
					break;
				case START:
					RELAY_set_level(true & !humidity_alarm);
					pump_remaining = PUMP_LENGTH;
					pump_mode_next = RUN;
					break;
				case RUN:
					break;
				case STOP:
					RELAY_set_level(false);
					pump_mode_next = IDLE;
					break;
				case WAIT:
					BTN_NOW_LED_set_level(true);
					BTN_WAIT_LED_set_level(true);
					break;
				case OFF:
					BTN_NOW_LED_set_level(true);
					BTN_WAIT_LED_set_level(true);
				break;
			}			
		}
		
		if (USART_0_is_rx_ready()) {
			while(USART_0_is_rx_ready()) {			
				if (USART_0_read() == 't') {
					eepromDump();
				}
			}
		}
				
		_delay_ms(10);
	}

}
