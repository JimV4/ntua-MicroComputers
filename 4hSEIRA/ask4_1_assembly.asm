;
; AssemblerApplication1.asm
;
; Created: 5/28/2022 7:56:57 PM
; Author : dhmht
;

.include "m16def.inc"

reset:      ldi r24 , low(RAMEND)   	; initialize stack pointer
		    out SPL , r24
			ldi r24 , high(RAMEND)
			out SPH , r24
			ser r24                    	; initialize PORTΒ as output
			out DDRB , r24
			clr r26                   	; clear time counter
			clr r27
			out DDRA, r27				; initialize PORTA as input
			clr r28						; r28 will be used as a flag

			ldi r26, 1					; initialize output with 00000001

main:
	cpi r26 , 128				; check if 10000000 is reached
	breq reverse				; if so reverse led movement
	ldi r28 , 1					; led moving left so r28 = 1
	in r27 , PINA				; check if push button PA0 of PINA is pushed
	andi r27 , 0x01
	cpi r27 , 0x01
	breq stop					; if yes stop

continue_left:
	out PORTB , r26				; else store output  
	ldi r24 , low(500)			; load r25:r24 with 500 
	ldi r25 , high(500)        
	rcall wait_msec				; delay 0.5 second
	lsl r26						; shift left led output
	rjmp main					; repeat

reverse:						
	cpi r26 , 1					; check if 00000001 is reached
	breq main					; if so reverse led movement
	ldi r28 , 0					; led moving right so r28 = 0
	in r27, PINA				; check if push button PA0 of PINA is pushed
	andi r27 , 0x01
	cpi r27 , 0x01
	breq stop					; if yes stop

continue_right:
	out PORTB , r26
	ldi r24 , low(500)			; load r25:r24 with 500 
	ldi r25 , high(500)        
	rcall wait_msec				; delay 0.5 second
	lsr r26						; shift left led output
	rjmp reverse				; repeat

stop:
	in r27 , PINA				; check if push button PA0 of PINA is released
	andi r27 , 0x01
	cpi r27 , 0x01
	brne check_continue			; if so we must continue
	rjmp stop					; else loop

	check_continue:				; based on the value of flag, we continue the movement left or right after the push button is released
		cpi r28 , 1
		breq continue_left
		rjmp continue_right


wait_msec:
   	push r24					; 2 κύκλοι (0.250 μsec)
   	push r25					; 2 κύκλοι
 	ldi r24 , low(998)      	; φόρτωσε τον καταχ.  r25:r24 με 998 (1 κύκλος - 0.125 μsec)
  	ldi r25 , high(998)     	; 1 κύκλος (0.125 μsec)
   	rcall wait_usec        		; 3 κύκλοι (0.375 μsec), προκαλεί συνολικά καθυστέρηση 998.375 μsec 
								; Στην προσομοίωση δεν βάζουμε χρονοκαθυστέρηση!      
   	pop r25               		; 2 κύκλοι (0.250 μsec)
   	pop r24               		; 2 κύκλοι 
   	sbiw r24 , 1          		; 2 κύκλοι 
   	brne wait_msec        		; 1 ή 2 κύκλοι (0.125 ή 0.250 μsec)
   	ret							; 4 κύκλοι (0.500 μsec)

wait_usec:   
	sbiw r24 ,1      		; 2 κύκλοι (0.250 μsec)  
	nop           			; 1 κύκλος (0.125 μsec)
	nop          			; 1 κύκλος (0.125 μsec)
	nop           			; 1 κύκλος (0.125 μsec)
	nop           			; 1 κύκλος (0.125 μsec)
	brne wait_usec			; 1 ή 2 κύκλοι (0.125 ή 0.250 μsec)
    ret             		; 4 κύκλοι (0.500 μsec)
