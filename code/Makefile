# Devices
MCU_GCC    = attiny13
MCU_DUDE   = t13
PROGRAMMER = usbasp

# ATtiny13a
# To calculate the fuses, see http://www.engbedded.com/fusecalc
LFUSE      = 0x6a
HFUSE      = 0xff
BITCLOCK   = 250
F_CPU      = 1200000  # Main clock frequency (9.6Mhz/8 = 1.2Mhz)

# GCC config
CC         = avr-gcc
CFLAGS     = -std=gnu99
CFLAGS     += -Os -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums
CFLAGS     += -mmcu=$(MCU_GCC) -DF_CPU=$(F_CPU)
CFLAGS     += -Wall -Wstrict-prototypes
LDFLAGS    =
TARGET     = main.hex

# Avrdude config
DUDE = avrdude


%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.elf: %.o
	$(CC) $(LDFLAGS) $< -o $@

%.hex: %.elf
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .signature $< $@

all: $(TARGET)

upload: $(TARGET)
	$(DUDE) -c $(PROGRAMMER) -p $(MCU_DUDE) -P usb -B $(BITCLOCK) -F -U flash:w:$(TARGET):i

setfuses:
	$(DUDE) -c $(PROGRAMMER) -p $(MCU_DUDE) -P usb -B $(BITCLOCK) -F -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m

clean:
	rm -f main.o main.elf main.hex

.PHONY: clean setfuses
