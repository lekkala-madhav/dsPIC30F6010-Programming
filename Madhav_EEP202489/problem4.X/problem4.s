.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset
	
	.text
    __reset:
    
    ; MATRIX A
    MOV #1, W0
    MOV W0, 0x1000
    MOV #2, W0
    MOV W0, 0x1002
    MOV #3, W0
    MOV W0, 0x1004
    MOV #4, W0
    MOV W0, 0x1006
    MOV #5, W0
    MOV W0, 0x1008
    MOV #6, W0,
    MOV W0, 0x100A
    MOV #7, W0
    MOV W0, 0x100C
    MOV #8, W0
    MOV W0, 0x100E
    MOV #9, W0
    MOV W0, 0x1010

    ; MATRIX B
    MOV #11, W0
    MOV W0, 0x1020
    MOV #12, W0
    MOV W0, 0x1022
    MOV #13, W0
    MOV W0, 0x1024
    MOV #14, W0
    MOV W0, 0x1026
    MOV #15, W0
    MOV W0, 0x1028
    MOV #16, W0,
    MOV W0, 0x102A
    MOV #17, W0
    MOV W0, 0x102C
    MOV #18, W0
    MOV W0, 0x102E
    MOV #19, W0
    MOV W0, 0x1030

    MOV #0x0000, W0	    ; PROGRAM COUNTER
    MOV #0x1000, W1	    ; MATRIX A START ADDRESS
    MOV #0x1020, W2	    ; MATRIX B START ADDRESS
    MOV #0x1040, W3	    ; MATRIX C START ADDRESS
    
    LOOP1: DO #8, END1	    ; LOOP FOR 9 TIMES (SIZE OF MATRIX)
    MOV [W1], W4	    ; TEMP STORE VALUE IN W4
    MOV [W2], W5	    ; TEMP STORE VALUE IN W5
    ADD W4, W5, [W3]	    ; ADD W4, W5 STORE IN [W3]
    INC2 W1, W1		    ; INCREMENT ADDRESS OF W1
    INC2 W2, W2		    ; INCREMENT ADDRESS OF W2
    INC2 W3, W3		    ; INCREMENT ADDRESS OF W3
    END1: INC W0, W0	    ; PROGRAM COUNTER INCREMENT
	