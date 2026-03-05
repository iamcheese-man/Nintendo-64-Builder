# N64 ROM Build Makefile
# Supports OPTIONS=n64 or OPTIONS=z64
# Default format: z64

# Path to libdragon
LIBDRAGON := ./libdragon
LIBDRAGON_INSTALL := $(LIBDRAGON)/install

# Output directory
BUILD_DIR := build
SRC := main.c

# ROM format
FORMAT ?= z64
ifeq ($(OPTIONS),)
	FORMAT := z64
else
	FORMAT := $(OPTIONS)
endif

# Compiler
CC := mips-linux-gnu-gcc
CFLAGS := -I$(LIBDRAGON_INSTALL)/include -O2 -G0 -Wall -mno-abicalls
LDFLAGS := -L$(LIBDRAGON_INSTALL)/lib -ldragon

# Output ROM
ROM_NAME := game.$(FORMAT)

all: $(BUILD_DIR)/$(ROM_NAME)

$(BUILD_DIR)/$(ROM_NAME): $(SRC)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $< -o $(BUILD_DIR)/game.elf $(LDFLAGS)
	$(LIBDRAGON_INSTALL)/bin/romconv $(BUILD_DIR)/game.elf -o $(BUILD_DIR)/$(ROM_NAME) -f $(FORMAT)
	@echo "Built ROM: $(BUILD_DIR)/$(ROM_NAME)"

clean:
	rm -rf $(BUILD_DIR)/*.elf $(BUILD_DIR)/*.z64 $(BUILD_DIR)/*.n64
