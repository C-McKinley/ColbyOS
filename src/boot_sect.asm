; A boot sector that boots CPP kernal in 32-bit protected mode
[org 0x7C00]
KERNAL_OFFSET equ 0x1000

	mov [BOOT_DRIVE], dl
	
	mov bp, 0x9000
	mov sp, bp
	mov bx, MSG_REAL_MODE
	call print_string
	
	call load_kernal
	
	call switch_to_pm
	
	jmp $

; Include
%include "pm/gdt.asm"
%include "disk/disk_load.asm"

[bits 16]

load_kernal:
	mov bx, MSG_LOAD_KERNAL
	call print_string
	
	mov bx, KERNAL_OFFSET
	mov dh, 15
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
MSG_LAOD_KERNAL db "Load kernal into memory", 0

times 510-($-$$) db 0
dw 0xaa55
