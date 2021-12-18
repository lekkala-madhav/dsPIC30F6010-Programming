;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Submission by	: Madhav Lekkala
;	Roll Number	: 2020EEP2489
;	Problem #	: Problem 1
;	Program des	: Generate series 2,5,8,11,14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset
	
	.text
    __reset:			; MAIN FUNCTION START
    MOV #0x1000, W4		; LOAD START ADDRESS TO W4
    MOV #0x0001, W0		; PROGRAM COUNTER (SELF)
    MOV #2, W1			; STARTING VALUE OF 2 STORED IN W1
    
    LOOP1:   DO #14, END1	; RUN LOOP FOR 15 TIMES
    MOV W1, [W4]		; MOV UPDATED VALYE TO W4 ADDRESS
    INC2 W4, W4			; INCREMENT ADDRESS BY 0x02
    ADD #3, W1			; ADD 3 TO PREV VALUE
    END1:   INC W0,W0		; INCREMENT SELF PROGRAM COUNTER
	
    


    
    
    

    
    


    
    
    
   