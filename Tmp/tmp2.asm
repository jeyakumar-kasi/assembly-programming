

section .data
    EatMsg db "Hello Jeyakumar!",10     ;
    EatLen equ $-EatMsg                 ;

section .bss

section .txt
    global _start


_start:
    mov eax, 4                           ; "sys_write" syscall
    mov ebx, 1                           ; File Descriptior Standard Output
    mov ecx, EatMsg
    mov edx, EatLen
    int 80h                             ; send output to display syscall
    
    mov eax, 1                          ; "exit" syscall
    mov ebx, 0                          ; Program return code as no errors
    int 80h                             ; send output to display syscall
    
    
    
    
