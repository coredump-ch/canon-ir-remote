# Devices
MCU_GCC    = attiny13
MCU_DUDE   = t13
PROGRAMMER = usbasp

# GCC config
CC      = avr-gcc
CFLAGS  = -Wall -mmcu=$(MCU_GCC) -std=gnu99 -Os
LDFLAGS = 
TARGET  = main.hex

# Avrdude config
DUDE = avrdude

# ATtiny13a fuses
LFUSE    = 0x6a
HFUSE    = 0xff
BITCLOCK = 250


%.elf: %.c
	$(CC) $(CFLAGS) $< -o $@

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
