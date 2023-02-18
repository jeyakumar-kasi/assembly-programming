
SECTION .data           ; Section for an initialized data
    Message: db "This is a tmp program", 10 ;
    MessageLen: equ $-Message               ; Get the string length

SECTION .bss        ; "         "   uninitialized data

SECTION .text       ; "     "       actual source code

global _start       ; starting point
_start:
    mov eax, 4      ; Call the Syscall
    mov ebx, 1      ; set the output to write the message
    mov ecx, Message; Move the message into the register
    mov edx, MessageLen; & the total length.
    int 80H         ; Execute the syscall

    ; mov ax, 067FEh  ;
    ; mov bx, ax      ;
    ; mov cl, bh      ;
    ; mov ch, bl      ;

    ; -- (OR) --
    ; xchg cl, ch        ; Exchange the both of 8 bit register values. (i.e Most significant Value & Least significant value)

    mov eax, 1      ; Exit the syscall
    mov ebx, 0      ; return the code from Program (i.e '0' => No Error)
    int 80H         ; Exit
