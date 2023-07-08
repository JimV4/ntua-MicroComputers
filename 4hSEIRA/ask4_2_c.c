#include <avr/io.h>

char A, B, C, D, F0, F1, res;

int main (void) {
	DDRB =0x00;	 	// initialize PORTB as input
	DDRA =0xFF;		// initialize PORTA as output
	
	while(1) {
		A = PINB & 0x01;	// A is given from PB0
		
		B = PINB & 0x02;	// B is given from PB1
		B = B >> 1;			// get B to LSB position
		
		C = PINB & 0x04;	// C is given from PB2
		C = C >> 2;			// get C to LSB position
		
		D = PINB & 0x08;	// D is given from PB3
		D = D >> 3;			// get D to LSB position
		
		F0 = (A & B & C) | ((~B) & (~C) & (~D));	// find F0
		F0 = F0 & 0x01;		// we are interested only on LSB
							// so keep only LSB
							
		F1 = (A | B | C) & D; 		// find F1
		F1 = F1 & 0x01;				// keep only LSB
		F1 = F1 << 1;				// F1 is shifted to 2nd LSB
		
		res = F0 | F1;		// calculate and show result to PORTA
		PORTA = res;
	}
	return 0;
}