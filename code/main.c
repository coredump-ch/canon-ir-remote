#include <avr/io.h>
#include <util/delay.h>

#define HPERIOD 0.01524
#define RATIO 0.4
#define NPULSES 16
#define INSTANT 7.33
#define DELAYED 5.36

#define LEDON  0b00010111
#define LEDOFF 0b00000001

void flash_led(void) {
    for(uint8_t i=0; i<NPULSES; i++) {
        PORTB = LEDON;
        _delay_ms(HPERIOD);
        PORTB = LEDOFF;
        _delay_ms(HPERIOD);
    }
}

int main(void) {
    // Set up I/O
    DDRB = _BV(PB1) | _BV(PB2) | _BV(PB4); // PB0 is input, PB1/2/4 are output
    PORTB = _BV(PB0); // Pull-up for input PB0

    // Reduce power consumption
    ADCSRA &= ~_BV(ADEN); // Disable ADC
    ACSR &= ~_BV(ACD); // Disable the analog comparator

    asm volatile ("nop");
    asm volatile ("nop");

    // Main loop
    while(1) {
        flash_led();
        _delay_ms(INSTANT);
        flash_led();

        _delay_ms(1000);
    }
}
