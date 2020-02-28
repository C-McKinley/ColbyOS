CPP_SOURCES = $(wildcard kernel/*.cpp)
HEADERS = $(wildcard kernel/*.h )
OBJ = ${CPP_SOURCES:.cpp=.o} 

CC = g++
CFLAGS = -Wall -Wextra -ffreestanding -Wall -m32

os-image.bin: boot/boot.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

%.o: %.cpp ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin boo/*.o
