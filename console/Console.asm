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



section .text                                ; actual code

; -------------------------------------------------------------------
; Clear the terminal
Clrscr:
    push eax                                ; Save Pertinent Registers
    push ebx
    push ecx
    push edx

    mov ecx, ClearTerminal                   ; Set "Clear Terminal" ctrl message
    mov edx, ClearTerminalLen

    call WriteStr                            ; send ctrl message to clear the terminal

    pop eax
    pop ebx
    pop ecx
    pop edx                                   ; Restore pertinent Registers

    ret                                       ; return to home




; -------------------------------------------------------------------
; Go to X, Y in the terminal
GotoXY:
    pushad

    xor ebx, ebx                               ; Clear EBX, ECX register
    xor ecx, ecx                               ;

    mov bl, al                                 ; Put Y value into Sclae Term EBX
    mov cx, word [Digits + ebx * 2]            ; Fetch decimal digits to CX (2 chars from Digits)
    mov word [PosTerminal + 2], cx             ; Invoke Digits to control string

    mov bl, ah                                 ; Put X value into Sclae Term EBX
    mov cx, word [Digits + ebx * 2]
    mov word [PosTerminal + 5], cx             ; Invoke Digits to control string (5th char in the given "PosTerminal" => <ESC>, "[01;01h")

    ; Send control message to terminal
    mov ecx, PosTerminal
    mov edx, PosTerminalLen
    call WriteStr

    ; return back
    popad
    ret



; -------------------------------------------------------------------
; Write the message at center of 80 char wide terminal
WriteCenter:
    push ebx
    xor ebx, ebx                                ; clear EBX

    mov bl, SCREENWIDTH                         ; Put screen width in ebx
    sub bl, dl                                  ; Difference from SCREENWIDTH - PosTerminalLen
    shr bl, 1                                  ; Divide difference by two (for X value)
    mov ah, bl                                  ; GotoXY - requires X vallue in "AH" register

    call GotoXY
    call WriteStr

    pop ebx
    ret


; -------------------------------------------------------------------
; Print the message in terminal
WriteStr:
    push eax
    push ebx

    mov eax, 4                                ; sys_write
    mov ebx, 1                                ; stdout
    int 80h

    pop eax
    pop ebx
    ret


global _start

_start:
    nop

    ; First clear the screen
    call ClearTerminal

    ; Then show the message at center of terminal
    mov al, 12                                  ; Set "Y" value  (i.e Line no)

    mov ecx, PosTerminal
    mov edx, PosTerminalLen
    call WriteCenter

    ; Position the cursor for promtp to "Press Enter"
    mov ax, 0117h                               ; Set X=1, Y=23 in a single Hex value
    call GotoXY

    ; Disply "Press Enter" message
    mov ecx, Prompt
    mov edx, PromptLen
    call WriteStr

    ; Wait for the user to press Enter key
    mov eax, 3                                    ; sys_Read
    mov ebx, 0                                    ; stdin
    int 80h


Exit:
    mov eax, 1                                    ; sys_exit
    mov ebx, 0                                    ; no error
    int 80h






