;
; AssemblerApplication3.asm
;
; Created: 5/29/2022 3:03:48 PM
; Author : dhmht
;


; Replace with your application code
.include "m16def.inc"

reset:      ldi r24 , low(RAMEND)   	; initialize stack pointer
		    out SPL , r24
			ldi r24 , high(RAMEND)
			out SPH , r24
			ser r24                    	; initialize PORTA as output
			out DDRA , r24
			clr r26                   	
			clr r27
			out DDRB , r26				; initialize PORTB as input
										

main:
	in r26 , PINB	; r26 contains input from PORTB

	;calculate F0
	mov r27 , r26 
	mov r28 , r26
	mov r29 , r26
	mov r30 , r26

	andi r27 , 1	; r27 holds A
	andi r28 , 2	; r28 holds B 
	lsr r28			; shifted to LSB
	andi r29 , 4	; r29 holds C
	lsr r29
	lsr r29			; shifted to LSB
	andi r30 , 8	; r30 holds D
	lsr r30
	lsr r30
	lsr r30			; shifted to LSB

First_AND:	
	and r27 , r28 
	and r27 , r29	; r27 contains ABC

Second_AND:
	com r28			; B'
	com r29			; C'
	com r30			; D'

	and r28 , r29
	and r28 , r30	; r28 contains B'C'D'

OR_Operation:
	or r27 , r28	; r27 contains F0 but we are interested only in LSB
	andi r27 , 1	; Andi with 1 because we are interested in LSB so now
					; r27 contains F0 in LSB
	mov r31 , r27	; save F0 to r31


; calculate F1
	mov r27 , r26 
	mov r28 , r26
	mov r29 , r26
	mov r30 , r26

	andi r27 , 1	; r27 holds A
	andi r28 , 2	; r28 holds B
	lsr r28			; shifted to LSB
	andi r29 , 4	; r29 holds C
	lsr r29
	lsr r29			; shifted to LSB
	andi r30 , 8	; r30 holds D
	lsr r30
	lsr r30
	lsr r30			; shifted to LSB

	or r27 , r28
	or r27 , r29	; r27 contains A + B + C
	and r27 , r30	; r27 contains F1 but we are interested only in LSB.
	andi r27 , 1	; r27 contains F1 (in LSB)
	lsl r27			; r27 contains F1 shifted to 2nd LSB

	or r27 , r31	; r27 contains result 0000 00F1F0
	out PORTA , r27	; show output
	rjmp main		; repeat
