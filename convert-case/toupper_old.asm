

; Read the character and convert to "Upper" case

section .data           ;
    FileName            db  "Hello.txt", 10;
    FileNameLen         equ $-FileName;
    
section .bss            ;

section .txt            ;
    global _start       ;
    
    
_start:
    mov eax, 4          ; Specify the "sys_write" call
    mov ebx, 1          ; Specify the File Descriptor for "Standard Output"
    mov ecx, FileName   ;
    mov edx, FileNameLen;
    int 80h             ; send output to display
    
    ; Exit the Program
    mov eax, 1          ; Specify the "sys_exit" call
    mov ebx, 0          ; Program code, (i.e No Errors)
    int 80h             ;
    
    
    



