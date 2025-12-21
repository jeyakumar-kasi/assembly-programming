
; Dec 12, 2024 | Jeyakumar Kasi
; A simple program in assembly for Linux, using NASM 2.05,
; demonstrating the use of the XLAT instruction to alter text streams.


SECTION .data
    StatusMsg: db "Processing...", 10
    StatusLen: equ $-StatusMsg
    DoneMsg: db "Done!", 10
    DoneLen: equ $-DoneMsg

    ; The following translation table translates all lowercase characters to
    ; uppercase. It also translates all non-printable characters to spaces,
    ; except for LF and HT.
    UpCase:
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
        db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
        db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
        db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
        db 60h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
        db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,7Bh,7Ch,7Dh,7Eh,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

    ; The following translation table is “stock“ in that it translates all
    ; printable characters as themselves, and converts all non-printable
    ; characters to spaces except for LF and HT. You can modify this to
    ; translate anything you want to any character you want.
    Custom:
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
        db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
        db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
        db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
        db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
        db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,7Ch,7Dh,7Eh,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
        db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h


SECTION .bss                  ; Unintialized data
    ReadLen: equ 1024         ; buffer size
    ReadBuf: resb ReadLen     ; buffer storage

SECTION .text                 ; actual Code
    global _start             ; Linker need this to find an "Entry point"

_start:
   nop                       ; No Operand
   call processing

processing:
    mov eax, 4                ; sys_write
    mov ebx, 2                ; file descriptor "stderr"
    mov ecx, StatusMsg
    mov edx, StatusLen
    int 80h;



read:
   ; Read the buffer value
   mov eax, 3                ; sys_read
   mov ebx, 0                ; file descriptor "stdin"
   mov ecx, ReadBuf
   mov edx, ReadLen
   int 80h

   ; Copy "sys_read" return value for safekeeping
   mov ebp, eax

   ; Check for "EOL"?
   cmp eax, 0
   je done

   ; Setup the register for translation.
   mov ebx, UpCase             ; set offset of "Upcase"
   mov edx, ReadBuf           ; set Offset of "Buffer"
   mov ecx, ebp               ; set the no. of bytes in buffer


translate:
   xor eax, eax               ; (#1)clear register
   mov al, byte [edx + ecx]   ; Load the Character from "Buffer" into "AL" register.
   mov al, byte [UpCase + eax]; (#2) Translate Character in AL via table.
   ; --(OR)-- xlat            ; (Instead of #1 & #2) Translate Character in AL via table.

   mov byte[edx + ecx], al    ; put the translated char back into "Buffer"
   dec ecx                    ; Decrement the counter
   jnz translate              ; Repeat "translation" until buffer count is zero.


writeBuffer:
   mov eax, 4                 ; sys_write
   mov ebx, 1                 ; file descriptor "stdout"
   mov ecx, ReadBuf
   mov edx, ebp
   int 80h

   jmp read

done:
    mov eax, 4                ; sys_write
    mov ebx, 2                ; file descriptor "stderr"
    mov ecx, DoneMsg
    mov edx, DoneLen
    int 80h;

    mov eax, 1                 ; sys_exit call
    mov ebx, 0                 ; No Error
    int 80h

;   call processing
;   call read
;   call exit




