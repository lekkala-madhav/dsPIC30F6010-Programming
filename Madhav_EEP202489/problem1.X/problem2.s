.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset
	
	.text
    __reset:
    MOV #0x1000, W4
    MOV #0x0001, W0
    MOV #2, W1
    
    
    LOOP1:   DO #10, END1
    MOV W1, [W4]
    INC2 W4, W4
    ADD #3, W1
    END1:   INC W0,W0
	


