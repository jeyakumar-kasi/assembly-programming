

section .data
    Message: db "Hello...",10; new line at end
    MessageLen: equ $-Message

    WelcomeMsg: db "Welcome...",10;
    WelcomeMsgLen: equ $-WelcomeMsg;

section .bss;
   nop;

section .text
    global _start;


write:
    mov eax, 4; sys_write
    mov ebx, 1; stdout
    int 80h;
    ret


_start:
    mov ecx, Message;
    mov edx, MessageLen;
    call write;

    mov ecx, WelcomeMsg
    mov edx, WelcomeMsgLen
    call write


    mov eax, 1; exit
    mov ebx, 0; no error
    int 80h;
