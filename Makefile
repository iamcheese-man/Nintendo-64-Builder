# N64 Builder Makefile
CC = gcc
CFLAGS = -O2 -Wall
LD = gcc
LDFLAGS = -Llibdragon_build/usr/local/lib -ldragon
INCLUDES = -Ilibdragon_build/usr/local/include

SRC = main.c
OBJ = $(SRC:.c=.o)

ROMNAME = game

format ?= n64

all: $(ROMNAME).$(format)

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(ROMNAME).n64: $(OBJ)
	$(LD) $(OBJ) $(LDFLAGS) -o build/$@

$(ROMNAME).z64: $(OBJ)
	$(LD) $(OBJ) $(LDFLAGS) -o build/$@

clean:
	rm -rf build/*.n64 build/*.z64 *.o
