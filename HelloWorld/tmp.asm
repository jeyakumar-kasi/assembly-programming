

section .data               ;
    Msg: db "Hello Jkasi"   ;
    MsgLen: equ $-Msg       ;   Find the length      

section .bss                ;

section .txt                ;
    global _start           ;

; ------------------------------------------------------------------------------

_linebreak:
    mov al, 13
    int 10h
    mov al, 10
    int 10h         ; display a line break

    
_newline:
    mov dl, 10          ; 10 -> \n
    mov ah, 02H         ;
    int 21H             ;
    
    mov dl, 13          ; 13 -> \r
    mov ah, 02H         ;
    int 21H             ;
    

_start:
    nop                 ;

    mov eax, 4          ; sys_write
    mov ebx, 1          ; write file descriptor to OUTPUT mode
    mov ecx, Msg        ; Message 
    mov edx, MsgLen     ; Message lengthny
    int 80H             ; Execute
    
;   New Line
; 	jmp _linebreak         
;   jmp _newline        ; Print new line 
    
    mov eax, 1          ; exit sys_write
    mov ebx, 0          ; return '0' from the Program
    int 80H             ; Execute and exit
    
; END
