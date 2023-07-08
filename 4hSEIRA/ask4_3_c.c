/*
 * ask4_3.c
 *
 * Created: 6/1/2022 4:39:03 PM
 * Author : dhmht
 */ 

#include <avr/io.h>

char res;			// res will store the output

int main(void)
{
    DDRA = 0x00;	// initialize PORTA as input
	DDRB = 0xFF;	// initialize PORTB as output
	
	res = 0x01;		// initialize result
	while (1) {
		PORTB = res;						// show output to PORTB
		if ((PINA & 0x01) == 0x01) {		// check if PA0 is pushed
			while ((PINA & 0x01) == 0x01);	// wait until button is released
			if (res == 0x80) {				// if led has reached MSB, move led to LSB
				res = 0x01;					 
			}
			else {
				res = res << 1;				// else shift left by one
			}
		
		if ((PINA & 0x02) == 0x02) {		// check if PA1 is pushed
			while ((PINA & 0x02) == 0x02);  // wait until button is released
			if (res == 0x01) {				// if led has reached LSB, move led to MSB
				res = 0x80;					
			}
			else {
				res = res >> 1;				// else shift right by one
			}
		}
		if ((PINA & 0x04) == 0x04) {		// check if PA2 is pushed
			while ((PINA & 0x04) == 0x04);  // wait until button is released
			if (res == 0x80) {				// if led has reached MSB, move led to 2nd LSB
				res = 0x02;
			}
			else if (res == 0x40) {			// else if led has reached 2nd MSB, move led to LSB
				res = 0x01;
			}
			else {
				res = res << 2;				// else shift led left by two
			}
		}
		if ((PINA & 0x08) == 0x08) {		// check if PA3 is pushed
			while ((PINA & 0x08) == 0x08);  // wait until button is released
			res = 0x80;						// move led to MSB
		}									
	}
	return 0;
}

