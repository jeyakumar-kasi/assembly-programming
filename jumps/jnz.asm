
SECTION .data    

SECTION .bss  

SECTION .text
    global  _start;
    
_start:
            
        MOV     eax, 5              ;     Set initial value

        
DoMore: DEC     eax         ;
        JNZ     DoMore      ;
        
        mov     eax, 45     ;
        NEG     eax         ;   become '-45' (Two's complement)
        add     eax, 45     ;   After adding '45' it becomes to '0'
        
        
        mov     ax, -45     ;
        movsx   ebx, ax     ; Move with Sign Extension (movsx)    
        
        
        mov eax, 1      ;
        mov ebx, 0      ;
        int 80H         ;
        
