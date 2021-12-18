// FOSC
#pragma config FPR = XTL                // Primary Oscillator Mode (XTL)
#pragma config FOS = FRC                // Oscillator Source (Internal Fast RC)
#pragma config FCKSMEN = CSW_FSCM_OFF   // Clock Switching and Monitor (Sw Disabled, Mon Disabled)

// FWDT
#pragma config FWPSB = WDTPSB_16        // WDT Prescaler B (1:16)
#pragma config FWPSA = WDTPSA_512       // WDT Prescaler A (1:512)
#pragma config WDT = WDT_OFF            // Watchdog Timer (Disabled)

// FBORPOR
#pragma config FPWRT = PWRT_64          // POR Timer Value (64ms)
#pragma config BODENV = BORV20          // Brown Out Voltage (Reserved)
#pragma config BOREN = PBOR_ON          // PBOR Enable (Enabled)
#pragma config LPOL = PWMxL_ACT_HIGH    // Low-side PWM Output Polarity (Active High)
#pragma config HPOL = PWMxH_ACT_HIGH    // High-side PWM Output Polarity (Active High)
#pragma config PWMPIN = RST_IOPIN       // PWM Output Pin Reset (Control with PORT/TRIS regs)
#pragma config MCLRE = MCLR_DIS         // Master Clear Enable (Disabled)

// FGS
#pragma config GWRP = GWRP_OFF          // General Code Segment Write Protect (Disabled)
#pragma config GCP = CODE_PROT_OFF      // General Segment Code Protection (Disabled)

// FICD
#pragma config ICS = ICS_PGD            // Comm Channel Select (Use PGC/EMUC and PGD/EMUD)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#include <libpic30.h>

int main()
{
    // Configure all four port D pins (RD0, RD1, RD2, RD3)
    // as digital outputs
    TRISD = 0b1111111111110000;
 
    // Set OC channel 1 pulse start and stop times
    OC1R = 0;           
    OC1RS = 25;
 
    // Set OC channel 2 pulse start and stop times
    OC2R = 10;
    OC2RS = 35;
 
    // Set output compare mode for continuous pulses
    OC1CONbits.OCM = 0b101;
    OC2CONbits.OCM = 0b101;
 
    // Configure timer 2 (default timer for output compare)
    PR2 = 50; // 0.1ms period
    T2CONbits.TON = 1; // Enable timer 2
    
    while(1)
    {
        // endless loop
    }
 
    return 0;
}
