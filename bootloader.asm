[BITS 64]
[ORG 0x7C00]

START:
    cli
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp 0x08:protected_mode

protected_mode:
    mov eax, cr4
    or eax, 0x20
    mov cr4, eax
    mov eax, 0xC0000080
    cpuid
    mov eax, ebx
    or eax, 0x80000000
    mov msr 0xC0000080, eax
    jmp 0x10:0x10000

TIMES 510 - ($ - $$) DB 0
DW 0xAA55
