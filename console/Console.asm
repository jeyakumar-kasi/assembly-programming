; Executable Name: console
; Version        : 1.0
; Updated On     : May 14, 2025 00:38
; Author         : Jeyakumar Kasi <jeyakumar.kasi@hyproid.com>
; Description    : Simple cursor control for the Linux console.
; Commands       :
;          Build : nasm -f elf -F STABS -g console.asm -o console.o
;          Linker: ld console.o -o console -m elf_i386
;          Run   : ./console
; ------------------------------------------------------------------------------------

section .data
    WelcomeMsg: db "Welcome",10
    WelcomeMsgLen: equ $-WelcomeMsg;


section .bss

section .txt
    global _start

_start:
    mov eax, 4; sys_write
    mov ebx, 1; file descriptor (STDOUT)
    mov ecx, WelcomeMsg;
    mov edx, WelcomeMsgLen;
    int 80h;

    mov eax, 1; sys_exit
    mov ebx, 0; No errors
    int 80h;



