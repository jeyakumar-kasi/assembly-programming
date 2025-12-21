; Print all chars to HEX from a given input file - Assembly program.
; ------------------------------------------------------------------

; Author		    : Jeyakumar Kasi <jeyakumar.kasi@hyproid.com>
; Created At		: 21 Jan, 2024 00:12
; Assemble Command	: nasm hello.asm -o hello.o -f elf -F STABS -g
; Linking Command	: ld hello.o -o hello -m elf_i386
; Run Command		: ./dump < hello.txt


section .bss ;
    BuffLen equ 16    ; We read a 16 bytes at a time
    Buff: resb BuffLen; Buffer


section .data;
    HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00", 10 ;
    HexStrLen equ $-HexStr;

    Digits: db "0123456789ABCDEF";

    EXITCHAR db 'q';

section .text;
    global _start      ;


; -----------------------------------------------------------------

_start:
    nop                ; No Operand

Read:
    mov eax, 3         ; sys_read
    mov ebx, 0         ; standard input
    mov ecx, Buff      ; Pass offset of the buffer
    mov edx, BuffLen   ; mention the no. of bytes to read.
    int 80h            ; execute.

    mov ebp, eax       ; save # bytes which was read to continue for next time.
    cmp eax, 0         ; Check is EOF in a file?
    je Done            ; Jump IF Equal on prev. camparision.

    ; Check for "exit" key is pressed?
;     mov bl, EXITCHAR   ;
;     cmp byte [Buff], bl;
;     je Done            ;

    jmp ConvertToHex   ; If NOT convert to HEX & print it.


ConvertToHex:
    ; jmp Write          ; print
    nop;


Write:
   mov eax, 4          ; sys_write
   mov ebx, 1          ; standard output
   mov ecx, Buff       ;
   mov edx, BuffLen    ;
   int 80h             ; Execute

   jmp Read            ; Read next 16 bytes.




Done:
   jmp Exit            ; Exit

Exit:
   mov eax, 1 ; sys_exit
   mov ebx, 0 ; No errors
   int 80h    ; Execute.






