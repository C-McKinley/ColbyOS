
all: os-image
run: all
	qemu-system-x86_64 $^ > os-image
os-image: boot.bin kernal.bin
	cat $^ > os-image
kernal.bin : kernal_entry.o kernal.o
	ld -o kernal.bin -Ttext 0x1000 $^ --oformat binary
kernal.o : kernal.cpp
	g++ -ffreestanding -c $< -o $@
keneral_entry.o : kernal_entry.asm
	nasm $< -f elf -o $@
clean:
	rm *.bin *.o
kernal.dis : kernal.bin
	ndisasm -b 32 $< > $@
