# Makefile for building N64 ROMs
TARGET = mygame

# Compiler and flags (using libdragon toolchain)
CC = mips64-elf-gcc
CFLAGS = -O2 -G0 -Wall -Ilibdragon/include
LDFLAGS = -T libdragon/build/crt0.ld -Llibdragon/build -ldragon

SRCS = main.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET).z64 $(TARGET).n64 $(TARGET).v64

# Standard Z64 output
$(TARGET).z64: $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Convert Z64 → N64 (byteswapped)
$(TARGET).n64: $(TARGET).z64
	dd if=$< of=$@ conv=swab

# Convert Z64 → V64 (byteswapped + 0x4000 header)
$(TARGET).v64: $(TARGET).z64
	dd if=$< of=$@ bs=1 skip=0 conv=swab

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET).z64 $(TARGET).n64 $(TARGET).v64
