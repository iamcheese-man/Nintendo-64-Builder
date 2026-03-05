CC := mips64el-elf-gcc
CFLAGS := -O2 -Ilibdragon_build/include
LDFLAGS := -Llibdragon_build/lib -ldragon
SRC := main.c
ELF := build/main.elf
ROM_N64 := build/main.n64
ROM_Z64 := build/main.z64
ROM_V64 := build/main.v64

all: $(ROM_N64)

$(ELF): $(SRC)
	mkdir -p build
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@

$(ROM_N64): $(ELF)
	python3 libdragon/tools/elf2n64.py $(ELF) $(ROM_N64)

$(ROM_Z64): $(ELF)
	python3 libdragon/tools/elf2n64.py --z64 $(ELF) $(ROM_Z64)

$(ROM_V64): $(ELF)
	python3 libdragon/tools/elf2n64.py --v64 $(ELF) $(ROM_V64)

clean:
	rm -rf build
