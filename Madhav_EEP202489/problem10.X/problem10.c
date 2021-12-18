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
 
unsigned int read_analog_channel(int n);
 
int main()
{
    // Declare a variable for the step time
    // so that it can be changed easily
    int v;
    long step_time = 300000L;
      
    // Make RD0-3 digital outputs
    TRISD = 0b0000;
 
    // Configure analog inputs
    TRISB = 0x01FF;      // Port B all inputs
    ADPCFG = 0xFF00;     // Lowest 8 PORTB pins are analog inputs
    ADCON1 = 0;          // Manually clear SAMP to end sampling, start conversion
    ADCON2 = 0;          // Voltage reference from AVDD and AVSS
    ADCON3 = 0x0005;     // Manual Sample, ADCS=5 -> Tad = 3*Tcy = 0.1us
    ADCON1bits.ADON = 1; // Turn ADC ON
     
    // Cycle through the four windings to make
    // the stepper turn forwards
    while(1)
    {
        // Read the analog channel. The result is an
        // integer between 0 and 1023 inclusive.
        v = read_analog_channel(0);
         
        // Now, update step time.
        // Because the value get too big for 16-bit ints,
        // the constant values are explicitly marked as
        // long values so that the calculation is carried
        // out using 32-bit ints.
        step_time = 150000L + 200L * v;
 
        // Cycle through the four stepper windings
        LATD = 0b1000; __delay32(step_time);
        LATD = 0b0100; __delay32(step_time);
        LATD = 0b0010; __delay32(step_time);
        LATD = 0b0001; __delay32(step_time);
    }
 
    return 0;
}
 
// This function reads a single sample from the specified
// analog input. It should take less than 2.5us if the chip
// is running at about 30 MIPS.
unsigned int read_analog_channel(int channel)
{
    ADCHS = channel;          // Select the requested channel
    ADCON1bits.SAMP = 1;      // start sampling
    __delay32(30);            // 1us delay @ 30 MIPS
    ADCON1bits.SAMP = 0;      // start Converting
    while (!ADCON1bits.DONE); // Should take 12 * Tad = 1.2us
    return ADCBUF0;
}
