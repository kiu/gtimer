/*
 * twihelper.h
 *
 * Created: 04.06.2021 19:52:45
 *  Author: kiu
 */ 


#ifndef TWIHELPER_H_
#define TWIHELPER_H_

void TWIStart(void);
void TWIStop(void);

void TWIWrite(uint8_t data);

uint8_t TWIReadACK(void);
uint8_t TWIReadNACK(void);

uint8_t TWIGetStatus(void);

#endif /* TWIHELPER_H_ */