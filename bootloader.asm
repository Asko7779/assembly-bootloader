[BITS 64]
[ORG 0x7C00]

START:
    cli
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    lgdt [gdt_descriptor]
    mov eax, cr4
    or eax, 0x2000
    mov cr4, eax
    mov eax, 0xC0000080
    rdmsr
    or eax, 0x100
    wrmsr
    jmp 0x08:protected_mode
protected_mode:
    mov rsi, 0x10000
    mov rdi, 2
    call load_kernel
    jmp 0x10000


load_kernel:
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x80
    int 0x13
    ret
gdt_start:
    dq 0x0
    dq 0x00CF9A000000FFFF
    dq 0x00CF92000000FFFF
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dw 0
    dd gdt_start
gdt_end:


TIMES 510 - ($ - $$) DB 0
DW 0xAA55
