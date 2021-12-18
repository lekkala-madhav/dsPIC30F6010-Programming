.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset
	
	.text
    __reset:
    ; KEPT W0, W1 RESERVED BECAUSE DIVISION IS NEEDED
    MOV #0x0000, W3	    ; STARTING VALUE 0
    MOV #0x0001, W4	    ; STARTING VALUE 1
    MOV #0x1004, W2	    ; MEMORY ADDRESS
    
    MOV W3, 0x1000	    ; STORING 1ST VALUE
    MOV W4, 0x1002	    ; STORING 2ND VALUE
    

    LOOP1: DO #12, END1	    ; FIRST 15 FIBONACCI NUMBERS
    ADD W3,W4,W5	    ; W3 = W1+W2
    MOV W5, [W2]	    ; W1=0, W2=1, W3=1 AND SO ON
    INC2 W2, W2		    ; INCREMENT ADDRESS
    MOV W4, W3		    ; INCREMENT ADDRESS
    END1:   MOV W5, W4	    ; INCREMENT PROGRAM COUNTER
    ; used till W5
 
    ; FOR AVERAGE CALCULATION
    MOV #0x1000, W6	    ; IMMEDIATE SUM
    MOV #0x0000, W7	    ; MIDDLE SUM
    MOV #0x0000, W8	    ; FINAL SUM
    LOOP2: DO #14, END2	    ; LOOP 15 TIMES
    ADD W7, [W6], W8	    ; W8 = W7+[W6]
    MOV W8, W7		    ; UPDATE VALUE
    END2:   INC2 W6, W6	    ; INCREMENT
    ; used till W8
    
    MOV #15, W9		    ; DENOMINATOR
    REPEAT #17		    ; REQUIRED INSTRUCTION
    DIV.U W8, W9	    ; DIVISON
    
    