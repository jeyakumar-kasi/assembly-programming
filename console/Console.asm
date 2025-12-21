; Executable Name: console
; Version        : 1.0
; Updated On     : May 14, 2025 00:38
; Author         : Jeyakumar Kasi <jeyakumar.kasi@hyproid.com>
; Description    : Simple cursor control for the Linux console.
; Commands       :
;          Build : nasm -f elf -F STABS -g console.asm -o console.o
;          Linker: ld console.o -o console -m elf_i386
;          Run   : ./console
; ------------------------------------------------------------------------------------



section .data
    SCREENWIDTH: equ 80                     ; Assume screen width as "80" chars

    PosTerminal: db 27,"[01;01h"            ; ESC,"<y>;<x>h"
    PosTerminalLen: equ $-PosTerminal               ; PosTerminal length

    ClearTerminal: db 27,"[2J"              ; ESC,"[2J"
    ClearTerminalLen: equ $-ClearTerminal

    Msg: db "Hello, this is the center of terminal"
    MsgLen: equ $-Msg

    Prompt: db "Press Enter..."
    PromptLen: equ $-Prompt

    ; This table gives us pairs of ASCII digits from 0-80. Rather than
    ; calculate ASCII digits to insert in the terminal control string,
    ; we look them up in the table and read back two digits at once to
    ; a 16-bit register like DX, which we then poke into the terminal
    ; control string PosTerm at the appropriate place. See GotoXY.
    ; If you intend to work on a larger console than 80 X 80, you must
    ; add additional ASCII digit encoding to the end of Digits. Keep in
    ; mind that the code shown here will only work up to 99 X 99.
    Digits: db "0001020304050607080910111213141516171819"
            db "2021222324252627282930313233343536373839"
            db "4041424344454647484950515253545556575859"
            db "606162636465666768697071727374757677787980"


section .bss                                ; Uninitialized data



section .txt                                ; actual code

; -------------------------------------------------------------------
; Clear the terminal
Clrscr:
    push eax                                ; Save Pertinent Registers
    push ebx
    push ecx
    push edx

    mov ecx, ClearTerminal                   ; Set "Clear Terminal" ctrl message
    mov edx, ClearTerminalLen

    call WriteStr                            ; send ctrl message to terminal to clear

    pop eax
    pop ebx
    pop ecx
    pop edx

    ret                                       ; return to home







    global _start;

_start:
    nop;
