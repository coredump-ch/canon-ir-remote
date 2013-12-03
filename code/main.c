//cpu main clock frequency, needed for delay library 
//check datasheet for further information 
#define F_CPU 1200000 //9.6Mhz/8 = 1.2Mhz 

#include <avr/io.h> 
#include <util/delay.h> 

int main(void) {
    DDRB = 0x01; //PB0 is set to output

    while(1) {  //Infinite loop
        PORTB ^= 0x01; // Change PB0 bit, 0 to 1, 1 to 0
        _delay_ms(200); // One second delay
    }

    return 0;
}
