
; Compares the two operand (A & B)
; Prints "YES" if "A > B"
; Prints "NO" if "A < B"
; Prints "EQUAL" if "A == B"


section .data;
    Message: db "Welcome to comparision program.", 10;
    MessageLength: equ $-Message;

    AMessage: db "Output: A is greater than B.", 10;
    AMessageLength: equ $-AMessage;

    BMessage: db "Output: B is greater than A.", 10;
    BMessageLength: equ $-BMessage;




section .bss;
    ; Dynamic variables
    a: resb 4;
    b: resb 5;


section .text;
    global _start;

; -----------------

printMessage:
    ; Prints the message stored in "ecx" register.
    mov eax, 4; sys_write
    mov ebx, 1; output file descriptor

    int 80h;
    ret


write:
    mov ecx, Message;
    mov edx, MessageLength;

    call printMessage;
    ret;


exit:
    mov eax, 1; sys_exit
    mov ebx, 0; set "no error"

    int 80h; sys_call
    ret;




; -----------------


_start:
    call write;

;     mov word [a], 4;
    mov eax, [a];


;     mov word [b], 5;
    mov ebx, [b];


    ; Compare "a > b"
    cmp eax, ebx;
    jg printA; Jump IF Greater  (OR) when "Zero Flag" ZF is "0".
    jmp printB; Else print B


; -----------------



printA:
    mov ecx, AMessage;
    mov edx, AMessageLength;

    call printMessage;


printB:
    mov ecx, BMessage;
    mov edx, BMessageLength;

    call printMessage;


; -----------------


; Exit the program
jmp exit;





