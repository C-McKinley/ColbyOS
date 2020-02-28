; A boot sector that boots CPP kernal in 32-bit protected mode
[org 0x7c00]
KERNAL_OFFSET equ 0x1000

	mov [BOOT_DRIVE], dl
	
	mov bp, 0x9000
	mov sp, bp
	mov bx, MSG_REAL_MODE
	call print
	call print_nl
	
	call load_kernal
	
	call switch_to_pm
	
	jmp $

; Include
%include "boot/gdt.asm"
%include "boot/disk_load.asm"
%include "boot/print.asm"
%include "boot/switch_pm.asm"
%include "boot/print_hex.asm"
%include "boot/print_pm.asm"
[bits 16]

load_kernal:
	mov bx, MSG_LOAD_KERNAL
	call print
	call print_nl
	
	mov bx, KERNAL_OFFSET
	mov dh, 31
	mov dl, [BOOT_DRIVE]
	call disk_load
	
	ret

[bits 32]

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	call KERNAL_OFFSET

	jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Sucessfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNAL db "Load kernal into memory", 0

times 510-($-$$) db 0
dw 0xaa55
