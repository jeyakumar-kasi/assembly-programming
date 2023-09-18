


section .data               ;
section .txt                ;


global _start               ;

_start:                     ;
    mov     eax,    'WXYZ'  ;
    xchg    cl,  bh         ;
    ; div          
    ; shr                   ; SHIFT RIGHT 10 times faster than => DIV
    nop
    



section .bss        ;

