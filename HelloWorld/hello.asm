; Hello World - Assembly program.
; ----------------------------------

; Author		    : Jeyakumar Kasi <jai@hyproid.com>
; Created At		: 03 Jun, 2022 15:31
; Assemble Command	: nasm hello.asm -o hello.o -f elf -F STABS -g
; Linking Command	: ld hello.o -o hello -m elf_i386
; Run Command		: ./hello
 

SECTION .data                       ; Section for intialized data
    HelloMsg: db "Hello world!",10  ; String
    HelloLen: equ $-HelloMsg        ; string len

SECTION .bss                        ; Section for unintialized data
SECTION .text                       ; Section for source code
    global _start                   ; Linker needs this to find the entry point..

; ------------------------------------------------------------------------------    

; _linebreak:
;     mov al, 13
;     int 10h
;     mov al, 10
;     int 10h         ; display a line break
; 
; _newline:
;     mov dl, 10          ; 10 -> \n
;     mov ah, 02H         ;
;     int 21H             ;
;     
;     mov dl, 13          ; 13 -> \r
;     mov ah, 02H         ;
;     int 21H             ;
    

_start:
	nop				
	mov eax,4			; sys_write syscall
	mov ebx,1			; Write File descriptor 1, i.e Output
	mov ecx,HelloMsg    ; Set the Offset of the string
	mov edx,HelloLen    ; Set the string length
	int 80H             ; Call the syscall to execute (i.e Send the string to stdout)
	
	;New Line
	;jmp _linebreak         
    ;jmp _newline        ; Print new line 

	mov eax,1           ; Specify exit syscall
	mov ebx,0           ; returns the code '0' from program
	int 80H             ; execute to exit from the program

; END


