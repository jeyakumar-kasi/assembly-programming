

; Compile	: nasm -f elf -F STABS -g filename.asm
; Link		: ld -o filename filename.o
; Run		: ./filename


SECTION .data	; for initialized data
	EatMsg: db "Hello Assembly", 10		; messsage to print
	EatLen: equ $-EatMsg				; Find message length

SECTION .bss	; for uninitialized data

SECTION .text	; contains the code

global _start	; entry point



; Program
; --------------------------------
_start:
	nop			; No operand
	mov	eax, 4	; Specify sys_write syscall
	mov ebx, 1	; Specify File Descriptor 1, i.e standard output
	
	mov ecx, EatMsg		; pass message offset
	mov edx, EatLen		; pass the message length
	int 80h				; Make syscall to output the text to stdout
	
	mov eax, 1			; exit sys_call
	mov ebx, 0			; Return No error from Program
	int 80h				; execute
	
	
	
	
	
	

