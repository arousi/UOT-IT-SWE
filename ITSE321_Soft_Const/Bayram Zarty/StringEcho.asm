.model small
.stack 100h

.data
buffer db 80h  ; Maximum length of string is 128 characters
prompt db 'Enter a string: $'
newline db 0Dh, 0Ah, '$'

.code
main proc
    ; Initialize DS register
    mov ax, @data
    mov ds, ax

    ; Display prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read string from keyboard
    lea dx, buffer
    mov ah, 0Ah
    int 21h

    ; Wait for an interrupt
    ; This is just a placeholder for an actual interrupt handler
    ; which could be implemented if needed
    nop

    ; Display newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Display the string
    lea dx, buffer+1  ; The actual string starts from buffer[1]
    mov ah, 09h
    int 21h

    ; Terminate program
    mov ax, 4C00h
    int 21h
main endp
end main
