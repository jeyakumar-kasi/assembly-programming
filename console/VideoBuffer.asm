; A simpe program to demonstrate the String instructions by faking the
; Full screen memory-mapped text I/O.
;

section .data
    EOL equ 10
    FILLCHR equ 32    ; space char
    HBARCHR equ 196   ; show "-" for invaid char
    STRTROW equ 2     ; Row where the Graph begins

    ; Dataset just a tabe of byte-length number
    Dataset db 9,71,17,52,55,18,29,36,18,68,77,63,58,44,0

    Message: db "Hello Jeyakumar", 10
    MessageLen: equ $-Message

    CLEAR     db 27,"[2J",  27,"[01;01h"
    CLEARLEN equ $-CLEAR

    ROWS equ  25        ; Total no. of lines
    COLS equ  81        ; Line Length incuding EOL char



section .bss                     ; unitialized data
    VideoBuff resb COLS * ROWS   ; Buffer Size


section .text
    global _start


    ; Clear the terminal
    %macro ClearTerminal 0
           pushad                ; Save all register data

           mov eax, 4           ; sys_write
           mov ebx, 1           ; output
           mov ecx, CLEAR
           mov edx, CLEARLEN
           int 80h

           popad

    %endmacro


    ; Write VideoBuff in terminal
    Show:
        pushad

        mov eax, 4
        mov ebx, 1
        mov ecx, VideoBuff
        mov edx, COLS * ROWS

        popad
        ret


    FillVideoBuff:
        push eax
        push ecx
        push edi              ; Extended Destionation Index

        cld                   ;## Clear DF (Clear Direction Flag), counting up memory

        mov al, FILLCHR       ; Setting the "Filling" char
        mov edi, VideoBuff    ; Pointing Destination to  VideoBuff
        mov ecx, COLS * ROWS  ; Setting the total no. of chars to be filled.

        rep stosb             ; Start to fill


        ; Buffer is done, now need to re-insert the EOL char for every lines.
        mov edi, VideoBuff    ; Pointing Destination to  VideoBuff again.
        dec edi               ; Start EOL position count for VideoBuff at char "0"th position.
        mov ecx, ROWS         ; setting no. of rows to go.

    SetEOL:
        add edi, COLS         ; Add Column count to edi
        mov byte [edi], EOL   ; Set EOL char at end of line.
        loop SetEOL           ;## Repeat until "ECX" become to "0"

        pop edi
        pop ecx
        pop eax

        ret




    ; Write the string to buffer at X, Y positions
    WriteLine:
        push eax
        push ebx
        push ecx
        push edi

        cld                    ; Clear the Direction Flag
        mov edi, VideoBuff     ; Pointing Destination to  VideoBuff
        dec eax                ; (Y value) Decrement 1 to start from "0" th (i.e one step back) position
        dec ebx                ; (X value) Decrement 1           "          "                "

        ; @doubt
        mov ah, COLS           ; set the number of columns
        mul ah                 ; Do 8 bit calculation "al * ah" and store it in "ax"

        ; @doubt
        add edi, eax           ; Add Y Offset into VideoBuff to "edi"
        add edi, ebx           ; Add X Offset into VideoBuff to "edi"

        rep movsb              ; Move the number of bytes specified in "CX" register (i.e Write the string in buffer)

        pop edi
        pop ecx
        pop ebx
        pop eax
        ret


    ; Write the Horizantal line by the given char.
    WriteHorzBar:
        push eax
        push ebx
        push ecx
        push edi

        cld                    ; Clear Direction Flag
        mov edi, VideoBuff
        dec eax                ; (Y value) Decrement 1 to start from "0" th (i.e one step back) position
        dec ebx                ; (X value) Decrement 1           "          "                "

        ; @doubt
        mov ah, COLS           ; set no. of columns
        mul ah                 ; Do 8 bit calculation "al * ah" and store it in "ax"

        add edi, eax
        add edi, ebx

        mov al, HBARCHR       ; Set the Horizantal bar char to display.
        rep stosb             ; Write the char from Register (i.e al) to memory (i.e buffer) repeatedly for 'n' times given in "cx".

        pop edi
        pop ecx
        pop ebx
        pop eax
        ret














_start:

    call ClearTerminal
    call FillVideoBuff

    mov eax, 4; sys_write
    mov ebx, 1; output

    mov ecx, Message
    mov edx, MessageLen

    int 80h





exit:
    mov eax, 1; sys_exit
    mov ebx, 0; No error

    int 80h;




