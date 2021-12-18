.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset
;..............................................................................
;Configuration bits:
;..............................................................................


        config __FWDT, WDT_OFF              ;Turn off Watchdog Timer

        config __FBORPOR, RST_IOPIN

	.text
    __reset:
		    
    mov #0b1111111111110000, w0
    
    mov w0, TRISD

    mov #0, w0
    mov w0, OC1R
    
    mov #25, w0
    mov w0, OC1RS
    
    mov #0, w0
    mov w0, OC2R
    
    mov #25, w0
    mov w0, OC2RS
    
    mov #0b0000000000000101, w0
    mov w0, OC1CON
    
    mov #0b0000000000000101, w0
    mov w0, OC2CON
    
    mov #50, w0
    mov w0, PR2
    
    bset T2CON #15
    
    BRA LOOP
    
    LOOP: BRA LOOP
    
    
    
    