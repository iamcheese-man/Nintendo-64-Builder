# N64 Build Makefile
# Supports: n64 and z64 outputs

# Local libdragon paths
LIBDRAGON_DIR := $(CURDIR)/libdragon
LIBDRAGON_BUILD := $(CURDIR)/libdragon_build

CC := mips64-elf-gcc
CFLAGS := -O2 -G0 -Wall -I$(LIBDRAGON_DIR)/include
LDFLAGS := -L$(LIBDRAGON_BUILD)/lib -ldragon

TARGET := build/mygame
SRC := main.c

# ROM format: n64 or z64
ROM_FORMAT ?= z64

# Output files
N64_ROM := $(TARGET).n64
Z64_ROM := $(TARGET).z64

all: $(N64_ROM) $(Z64_ROM)

$(N64_ROM): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET).elf $^ $(LDFLAGS)
	$(LIBDRAGON_DIR)/tools/elf2n64 $(TARGET).elf $(N64_ROM)

$(Z64_ROM): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET).elf $^ $(LDFLAGS)
	$(LIBDRAGON_DIR)/tools/elf2z64 $(TARGET).elf $(Z64_ROM)

clean:
	rm -rf build/*.elf build/*.n64 build/*.z64
