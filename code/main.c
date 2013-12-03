#include <avr/io.h> 
#include <util/delay.h> 

int main(void) {
    DDRB = 0x01; //PB0 is set to output

    while(1) {  //Infinite loop
        PORTB ^= 0x01; // Change PB0 bit, 0 to 1, 1 to 0
        _delay_ms(200); // Delay
    }

    return 0;
}
