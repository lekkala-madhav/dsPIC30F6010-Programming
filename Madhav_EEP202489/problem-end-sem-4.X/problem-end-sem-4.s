.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset

	.text
    __reset:

    mov #0b1111111111110000, w0
    mov w0, TRISD
    
    mov #0x01FF, w0
    mov w0, TRISB
    
    mov #0xFF00, w0
    mov w0, ADPCFG
    
    mov #0, w0
    mov w0, ADCON1

    mov #0, w0
    mov w0, ADCON2
    
    mov #0x0005, w0
    mov w0, ADCON3

    bset ADCON1, #15
    
    
    LOOP:
	CALL LOOP1
	mov #0, w0
	mov w0, OC1R
	
	MOV ADCBUF0, W2
	MOV W2, OC1RS


	mov #0b0000000000000101, w0
	mov w0, OC1CON

	mov #0b0000000000000101, w0
	mov w0, OC2CON

	mov #1024, w0
	mov w0, PR2

	bset T2CON, #15
	BRA LOOP
	
    LOOP1: 
	mov #0, w1
	mov w1, ADCHS
	bset ADCON1, #SAMP
	BRA DELAY1
	DELAY1: DO #10000, ENDDELAY1
	NOP
	NOP
	ENDDELAY1: NOP
	BCLR ADCON1, #SAMP
	BRA DELAY2
	DELAY2: DO #10000, ENDDELAY2
	NOP
	NOP
	ENDDELAY2: NOP
	RETURN  
	