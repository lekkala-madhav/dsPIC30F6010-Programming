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
    
    
    mov #0x0400, w0	    ; PWM module is disabled, continue operation in
    mov w0, PTCON	    ; Idle mode, special event interrupt disabled,
			    ; immediate period updates enabled, no external
			    ; synchronization
    ; Set the PWM Period
    mov #0x094D, w0	    ; Select period to be approximately 2.5?s
    mov w0, PTPER	    ; PLL Frequency is ~480MHz. This equates to a
			    ; clocke period of 2.1ns. The PWM period and
			    ; duty cycle registers are triggered on both +ve
			    ; and -ve edges of the PLL clock. Therefore,
			    ; one count of the PTPER and PDCx registers
			    ; equals 1.05ns.
			    ; So, to achieve a PWM period of 2.5?s, we
			    ; choose PTPER = 0x094D
    ; Select individual Duty Cycle Control
    mov #0x0001, w0	    ; Fault interrupt disabled, Current Limit
    mov w0, PWMCON1	    ; interrupt disabled, trigger interrupt,
			    ; disabled, Primary time base provides timing,
			    ; DC1 provides duty cycle information, positive
			    ; dead time applied, no external PWM reset,
			    ; Enable immediate duty cycle updates
    ; Duty Cycle Setting
    mov #0x094D, w0	    ; To achieve a duty cycle of 50%, we choose
    mov w0, PDC1	    ; the PDC1 value = 0.5*(PWM Period)
			    ; The ON time for the PWM = 1.25?s
			    ; The Duty Cycle Register will provide
			    ; positive duty cycle to the PWMxH outputs
			    ; when output polarities are active high
			    ; (see IOCON1 register)

    bset PTCON, #15	    ; turn ON PWM module

		