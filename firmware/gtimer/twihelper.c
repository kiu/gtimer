/*
 * twihelper.c
 *
 * Created: 04.06.2021 19:52:20
 *  Author: kiu
 */ 

#include <atmel_start.h>
#include "twihelper.h"

void TWIStart(void) {
	TWCR0 = (1<<TWINT)|(1<<TWSTA)|(1<<TWEN);
	while ((TWCR0 & (1<<TWINT)) == 0);
}

void TWIStop(void) {
	TWCR0 = (1<<TWINT)|(1<<TWSTO)|(1<<TWEN);
}

void TWIWrite(uint8_t data) {
	TWDR0 = data;
	TWCR0 = (1<<TWINT)|(1<<TWEN);
	while ((TWCR0 & (1<<TWINT)) == 0);
}

uint8_t TWIReadACK(void) {
	TWCR0 = (1<<TWINT)|(1<<TWEN)|(1<<TWEA);
	while ((TWCR0 & (1<<TWINT)) == 0);
	return TWDR0;
}

uint8_t TWIReadNACK(void) {
	TWCR0 = (1<<TWINT)|(1<<TWEN);
	while ((TWCR0 & (1<<TWINT)) == 0);
	return TWDR0;
}

uint8_t TWIGetStatus(void) {
	return TWSR0 & 0xF8;
}
