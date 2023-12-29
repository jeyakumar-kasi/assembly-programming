

section .data               ;
    EXIT_CHAR   db  'q';      113 -> 71h -> 'q'
    WelcomeMsg  db  "Type the string to convert to Lowercase", 10, "----------------------------------------", 10
    WelcomeMsgLen equ $-WelcomeMsg

    ExitMsg db "Press 'q' to exit.",10
    ExitMsgLen equ $-ExitMsg
    
    
section .bss                ;
    Buff    resb  1         ; Reserve 1 byte for buffer
    
    
section .txt                ;
    global _start           ;
    
    
_start:
    nop


Home:
    ; Welcome Message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, WelcomeMsg
    mov edx, WelcomeMsgLen
    int 80h


Message:
    ; Exit Instruction
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, ExitMsg
    mov edx, ExitMsgLen
    int 80h

    
Read:
    mov eax, 3              ; sys_read
    mov ebx, 0              ; stdin
    mov ecx, Buff           ; Pass the Buffer ADDRESS
    mov edx, 1              ; Mention buffer len
    int 80h                 
    
    ; Check for 'EOF'
    cmp eax, 0                  ; 0 -> EOF
    je Exit
    
    ; Check for 'EXIT' char is pressed?
    mov bl, [EXIT_CHAR]         ; IMPORTANT: Move the char value into the "Register" (8 bit) at first.
    cmp byte [Buff], bl         ;            then "compare" it with char in "buffer".
    je Exit
    
    cmp byte [Buff], 61h        ; Check against lowercase 'a'
    jb Write                    ; If below 'a' then not a lowercase.
    
    cmp byte [Buff], 7Ah        ; Check againt lowercase 'z'
    ja Write                    ; If Above 'z' then not a lowercase
    
    ; Else it should a "Lowercase"
    ; Subtract "20h" from "lowercase", to convert to uppercase (i.e backward for "32 char" in ascii chars.)
    sub byte [Buff], 20h
       

Write:
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, Buff           ; Send the Buffer ADDRESS.
    mov edx, 1              ; Mention the buffer len
    int 80h

    ; Read Next Char
    jmp Read



Exit:
    mov eax, 1              ; sys_exit
    mov ebx, 0              ; no error
    int 80h         

    
    
    
    
    
    
    
    
