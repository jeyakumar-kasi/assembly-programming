
section .data                ; initliazed data
    message db "Hello Jey", 10;
    messageLen equ $-message;

;section .bss                 ; uninitliazed data
;    nop

section .text                 ; main program
    extern puts                ; glibc funtion
    extern exit               ; glibc function
    global _start

_start:
     push ebp
     mov ebp,esp

     push ebx
     push edi
     push esi
     ; ------------------ [boiler code ends] ----------------------------
     ; Original code starta

     push message          ; push message to stack
     call puts             ; call glibc method
     add esp, 4            ; clean stack by adjusting ESP bacl by 4 bytes.

    push 0                 ; exit code 0 (success)
    call exit              ; call glibc exit function  

     ; Original code ends
     ; ------------------ [boiler code starts again] ----------------------------
     pop esi
     pop edi
     pop ebx

     mov esp, ebp         ; destroy stack frame before returning
     pop ebp

     ret                  ; return control to Linux


; To avoid the warning about the executable stack
section .note.GNU-stack noalloc noexec nowrite progbits

