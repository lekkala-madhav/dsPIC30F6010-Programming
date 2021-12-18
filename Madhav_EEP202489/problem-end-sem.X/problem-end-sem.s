;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Submission by	: Madhav Lekkala
;	Roll Number	: 2020EEP2489
;	Exam		: End Sem Test
;	Program des	: see below qn
	
;   Q1. Write a dspic executable program to generate 100 kHz PWM on
;   channel one and two (using PWM-channels of the processor) with
;   different duty ratios. The duty ratio count (minimum count in
;   channel-1 while maximum count in channel-2) needs to be load from the
;   given series (Assume the series as: 200, 079, 450, 721, 231, 367, 108,
;   917, 289, 333).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
.equ __30F6010, 1
	
	.include "p30f6010.inc"
	.global	__reset
;..............................................................................
;Configuration bits:
;..............................................................................


        config __FWDT, WDT_OFF              ;Turn off Watchdog Timer
	.text
    __reset:
    ;	series: 200, 079, 450, 721, 231, 367, 108, 917, 289, 333
    
    ;	this series is stored from 0x1000 to 0x1012
    
    MOV #200, W0
    MOV W0, 0x1000
    MOV #79, W0
    MOV W0, 0x1002
    MOV #450, W0
    MOV W0, 0x1004
    MOV #721, W0
    MOV W0, 0x1006
    MOV #231, W0
    MOV W0, 0x1008
    MOV #367, W0,
    MOV W0, 0x100A
    MOV #108, W0
    MOV W0, 0x100C
    MOV #917, W0
    MOV W0, 0x100E
    MOV #289, W0
    MOV W0, 0x1010
    MOV #333, W0
    MOV W0, 0x1012
    
    ; bubble sort starts
    
    MOV #0x0000, W0	    ; PROGRAM COUNTER FOR INNER LOOP
    MOV #0x0000, W5	    ; PROGRAM COUNTER FOR OUTER LOOP
    
    LOOP4: DO #8, END4	    ; OUTER LOOP FOR BUBBLE SORT
    MOV #0x1000, W1	    ; STARTING ADDRESS TO W1
    MOV #0x1002, W2	    ; STARTING ADDRESS TO W2
    LOOP1:  DO #8, END1	    ; INEER LOOP FOR IMMEDIATE SORT
	MOV [W1], W3	    ; TEMP STORAGE OF VALUE 1 FOR CP
	MOV [W2], W4	    ; TEMP STORAGE OF VALUE 2 FOR CP
	CP W3, W4	    ; CP SETS CARRY IF W3>W4
	BRA C, LOOP2	    ; BRANCH TO LOOP2 IF CARRY IS SET
	BRA LOOP3	    ; BRANCH TO LOOP3 IS IT ISNT
	
	LOOP2:	MOV W3, [W2]	; SWAPPING NUMBERS IF W3>W4	
	MOV W4, [W1]		; SWAPPING NUMBERS IF W3>W4
	BRA LOOP3		; BRANCH TO LOOP3 (UNCONDITIONAL)
	
	LOOP3: INC2 W1, W1	; INCREMENT ADDRESS 1 FOR NEXT SWEEP
	INC2 W2, W2		; INCREMENT ADDRESS 2 FOR NEXT SWEEP
    END1: INC W0,W0		; INNER LOOP PC INCREMENT
    END4: INC W5, W5		; OUTER LOOP PC INCREMENT
    
    ; end of sorting
    ; now the minimum value is stored in 0x1000 where the 
    ; maximum value is stored in 0x1012
    
    ; PWM1 needs minimum value (i.e. 0x1000)
    ; PWM2 needs maximum value (i.e. 0x1012)
    
    ; PWM Code starts from here
    
    mov #0x0400, w0	    ; PWM module is disabled, continue operation in
    mov w0, PTCON	    ; Idle mode, special event interrupt disabled,
			    ; immediate period updates enabled, no external
			    ; synchronization
    ; Set the PWM Period
    
    MOV #0x1012, W0	    ; MAXIMUM VALUE ADDRESS
    MOV [W0], W2
			    ; Select period to be approximately 2.5?s
    MOV W2, PTPER	    ; PLL Frequency is ~480MHz. This equates to a
			    ; clocke period of 2.1ns. The PWM period and
			    ; duty cycle registers are triggered on both +ve
			    ; and -ve edges of the PLL clock. Therefore,
			    ; one count of the PTPER and PDCx registers
			    ; equals 1.05ns.
			    ; So, to achieve a PWM period of 2.5?s, we
			    ; choose PTPER = 0x094D
    
    ; Select individual Duty Cycle Control
    	    

    mov #0xFFFF, w0	    ; Fault interrupt disabled, Current Limit
    mov w0, PWMCON1	    ; interrupt disabled, trigger interrupt,
			    ; disabled, Primary time base provides timing,
			    ; DC1 provides duty cycle information, positive
			    ; dead time applied, no external PWM reset,
			    ; Enable immediate duty cycle updates

    ; Duty Cycle Setting
    
    ; PWM1 needs minimum value (i.e. 0x1000)
    MOV #0x1012, W0	    ; MINIMUM VALUE ADDRESS
    MOV [W0], W1
    
			    ; To achieve a duty cycle of 50%, we choose
    MOV W1, PDC1	    ; the PDC1 value = 0.5*(PWM Period)
			    ; The ON time for the PWM = 1.25?s
			    ; The Duty Cycle Register will provide
			    ; positive duty cycle to the PWMxH outputs
			    ; when output polarities are active high
			    ; (see IOCON1 register)
			    
    ; PWM2 needs maximum value (i.e. 0x1012)
    MOV #0x1000, W0	    ; MIMIMUM VALUE ADDRESS
    MOV [W0], W2
			    ; To achieve a duty cycle of 50%, we choose
    MOV W2, PDC2	    ; the PDC1 value = 0.5*(PWM Period)
			    ; The ON time for the PWM = 1.25?s
			    ; The Duty Cycle Register will provide
			    ; positive duty cycle to the PWMxH outputs
			    ; when output polarities are active high
			    ; (see IOCON1 register)

    bset PTCON, #15	    ; turn ON PWM module