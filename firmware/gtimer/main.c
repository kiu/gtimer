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

uint8_t humidityMax = 0;
uint8_t humidityMaxLast = 0;

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

volatile uint8_t triggerRTC = true;
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

	if (pump_remaining > 0) {
		pump_remaining--;
	}

	if (pump_mode == RUN && pump_remaining == 0) {
		pump_mode_next = STOP;
	}

	if (t_second == 30) {
		triggerHTU = true;
	}

	if (t_second == 0) {
		
		if (t_minute == 15 || t_minute == 45) {
			triggerRTC = true;
		}
		
		if (t_minute == 0) {
			
			if (t_hour == 0) {
				triggerMidnight = true;
			}
			
			if (pump_mode == IDLE) {
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
	
	}

}

// ---------------------------------------------- Buttons

void btnNow() {
	printf("%02d:%02d:%02d Button: NOW\n", t_hour, t_minute, t_second);
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
	printf("%02d:%02d:%02d Button: WAIT\n", t_hour, t_minute, t_second);
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
	printf("%02d:%02d:%02d RTC update: ", t_hour, t_minute, t_second);
	
	uint8_t secRaw = readDS3231(0x00);
	uint8_t secValue = (secRaw >> 4) * 10 + (secRaw & 0b00001111);

	uint8_t minRaw = readDS3231(0x01);
	uint8_t minValue = (minRaw >> 4) * 10 + (minRaw & 0b00001111);

	uint8_t hrsRaw = readDS3231(0x02);
	uint8_t hrsValue = ((hrsRaw & 0b00110000) >> 4) * 10 + (hrsRaw & 0b00001111);

	t_second = secValue;
	t_minute = minValue;
	t_hour = hrsValue;

	printf("%02d:%02d:%02d\n", hrsValue, minValue, secValue);
}

// ---------------------------------------------- EEPROM

void eepromInit() {
	eeprom_index = (FLASH_0_read_eeprom_byte(0x3FE) << 8) + FLASH_0_read_eeprom_byte(0x3FF);
	printf("%02d:%02d:%02d EEPROM index: %d\n", t_hour, t_minute, t_second, eeprom_index);
}

void eepromWipe() {
	printf("%02d:%02d:%02d Clearing EEPROM ...", t_hour, t_minute, t_second);
	for (uint16_t i = 0; i < 0x3FF; i++) {
		FLASH_0_write_eeprom_byte(i, 0xFF);
	}
	
	FLASH_0_write_eeprom_byte(0x3FE, 0);
	FLASH_0_write_eeprom_byte(0x3FF, 0);	
	printf(" done\n");

	eepromInit();
}

void eepromUpdate(uint8_t t, uint8_t h) {
	FLASH_0_write_eeprom_byte(eeprom_index, t);
	eeprom_index++;
	FLASH_0_write_eeprom_byte(eeprom_index, h);
	eeprom_index++;
	if (eeprom_index >= 0x3FE) {
		eeprom_index = 0;
	}
	FLASH_0_write_eeprom_byte(0x3FE, eeprom_index >> 8);
	FLASH_0_write_eeprom_byte(0x3FF, eeprom_index);
	
	printf("%02d:%02d:%02d EEPROM new index: %d\n", t_hour, t_minute, t_second, eeprom_index);
}

void eepromDump() {
	printf("%02d:%02d:%02d EEPROM history\n", t_hour, t_minute, t_second);	
	printf("Day |Temp| Humid\n");
	
	uint16_t days = 0;
	
	for (uint16_t i = eeprom_index; i > 0; i-=2) {
		days++;
		printf("%04d %02dC %02d%%\n", days, FLASH_0_read_eeprom_byte(i - 2), FLASH_0_read_eeprom_byte(i - 1));
	}

	uint8_t tvalue = 0;
	uint8_t hvalue = 0;
		
	for (uint16_t i = 0x3FC; i > eeprom_index; i-=2) {
		days++;
		tvalue = FLASH_0_read_eeprom_byte(i);
		hvalue = FLASH_0_read_eeprom_byte(i + 1);
		if (tvalue != 0xFF || hvalue != 0xFF) {
			printf("%04d %02dC %02d%%\n", days, tvalue, hvalue);
		}
	}
	printf("\n");
}

// ---------------------------------------------- COMMANDS

void readCommands() {
	while(USART_0_is_rx_ready()) {
		char c = USART_0_read();
		switch (c) {
			case '?':
				printf("%02d:%02d:%02d Available commands\n", t_hour, t_minute, t_second);
				printf("\n");
				printf("m: Measure temperature and humidity\n");
				printf("z: Clear max temperature and humidity\n");
				printf("h: Show temperature and humidity history\n");				
				printf("e: Wipe temperature and humidity history\n");
				printf("\n");
				printf("s: Show humidity alarm status\n");
				printf("c: Turn humidity alarm off\n");
				printf("a: Turn humidity alarm on\n");
				printf("\n");
				printf("t: Show current time\n");
				printf("r: Sync time from RTC\n");
				printf("f: Trigger fake midnight\n");
				printf("\n");
				printf("n: Trigger NOW button\n");
				printf("w: Trigger WAIT button\n");
				printf("\n");
				printf("0: Turn pump off\n");
				printf("1: Turn pump on\n");
				printf("\n");
				break;

			case 'a':
			case 'A':
				printf("%02d:%02d:%02d Setting humidity alarm to ON\n", t_hour, t_minute, t_second);
				humidity_alarm = true;
				break;

			case 'c':
			case 'C':
				printf("%02d:%02d:%02d Setting humidity alarm to OFF\n", t_hour, t_minute, t_second);
				humidity_alarm = false;
				break;

			case 'e':
			case 'E':
				eepromWipe();
				break;

			case 'f':
			case 'F':
				triggerMidnight = true;
				break;

			case 'h':
			case 'H':
				eepromDump();
				break;

			case 'm':
			case 'M':
				triggerHTU = true;
				break;

			case 'n':
			case 'N':
				btnNow();
				break;

			case 'r':
			case 'R':
				triggerRTC = true;
				break;

			case 's':
			case 'S':
				printf("%02d:%02d:%02d Humidity alarm status: %d\n", t_hour, t_minute, t_second, humidity_alarm);
				break;

			case 't':
			case 'T':
				printf("%02d:%02d:%02d Time: %02d:%02d:%02d\n", t_hour, t_minute, t_second, t_hour, t_minute, t_second);
				break;

			case 'w':
			case 'W':
				btnWait();
				break;

			case 'z':
			case 'Z':
				printf("%02d:%02d:%02d Clearing max temperature and humidity\n", t_hour, t_minute, t_second);
				tempMax = 0;
				humidityMax = 0;
				break;

			case '0':
				printf("%02d:%02d:%02d Turning pump OFF\n", t_hour, t_minute, t_second);
				RELAY_set_level(false);
				break;

			case '1':
				printf("%02d:%02d:%02d Turning pump ON\n", t_hour, t_minute, t_second);
				RELAY_set_level(true);
				break;


		}
	}	
}

// ---------------------------------------------- MAIN

int main(void) {
	
	atmel_start_init();
	
	sei();
	
	printf("\nhttps://github.com/kiu/gtimer v0.2\n");
	printf("Enter '?' for available commands...\n\n");

	#if SETRTC
		setDS3231();
	#endif
	
	#if WIPEEEPROM
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

			uint8_t tvalue = readTemperature();
			if (tvalue > tempMax) {
				tempMax = tvalue;
			}			

			uint8_t hvalue = readHumidity();
			if (hvalue > humidityMax) {
				humidityMax = hvalue;
			}
			
			printf("%02d:%02d:%02d M: %02dC (%02dC / %02dC) %02d%% (%02d%% / %02d%%)\n", t_hour, t_minute, t_second, tvalue, tempMax, tempMaxLast, hvalue, humidityMax, humidityMaxLast);
			
			if (hvalue > HUMIDITY_ALARM_THRESHOLD) {
				humidity_alarm = true;				
				pump_mode_next = STOP;
				printf("\n*** HUMIDITY ALARM ***\n");
			}
		}
		
		if (triggerMidnight) {
			triggerMidnight = false;

			printf("%02d:%02d:%02d Midnight\n", t_hour, t_minute, t_second);
			
			tempMaxLast = tempMax;
			tempMax = 0;
			
			humidityMaxLast = humidityMax;
			humidityMax = 0;
			
			if (pump_mode == WAIT) {
				pump_mode_next = IDLE;
			}
			
			eepromUpdate(tempMaxLast, humidityMaxLast);
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
			printf("%02d:%02d:%02d Pump mode change from %s to %s\n", t_hour, t_minute, t_second, pump_mode_names[pump_mode], pump_mode_names[pump_mode_next]);
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
			readCommands();
		}
				
		_delay_ms(10);
	}

}
