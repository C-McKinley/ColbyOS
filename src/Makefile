C_SOURCES = $(wildcard ./*.c ./*.c)
HEADERS = $(wildcard ./*.h ./*.h)
OBJ = ${C_SOURCES:.c=.o}

CC = g++

os-image.bin: boot.bin kernel.bin
	cat $^ > os-image.bin
kernel.bin: kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

run: os-image.bin
	qemu-system-x86_64 -fda os-image.bin

%.o: %.c ${HEADERS}
	${CC} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm -f elf64 $< -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o
