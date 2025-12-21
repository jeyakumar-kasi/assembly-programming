

; jz - Jump If Zero


; Compile: nasm jz.asm -o jz.o -g -f elf -F STABS
; Linker : ld jz.o -o out.exe -m elf_i386
; Run    : ./out.exe

; Prints the "Hello World!" for 5 times in the terminal. (loop)
; -----------------------------------------------


section .data;
    Message: db "Hello World!",10;
    MessageLength: equ $-Message;

    Digits: db "0123456789";

section .bss;

section .text;
    global _start;

; --------------------------------------

_start:
    mov esi, 5             ; set the counter to "5 times"
    inc esi

    jmp loop               ;





write:
    mov eax, 4             ; sys_write
    mov ebx, 2             ; file descriptor (output)

    mov ecx, Message       ;
    mov edx, MessageLength ;
    int 80h                ; call sys_call (execute)




loop:
    dec esi                ; decrement counter by 1
    jz exit                ; Exit from loop if counter register set to "1".  (Non-Zero)

    ; Do the actual things here....
    jmp write              ;

    jmp loop               ; continue loop if counter register set to "0".







exit:
    mov eax, 1; sys_exit
    mov ebx, 0; set "no error"
    int 80h; call sys_call (execute)














