.MODEL small
.DATA
    niz db 23 DUP (' ')
.STACK
.CODE
start:
    mov ax, @data
    mov ds, ax
    
    lea bx, niz 
    mov cl, 20
    mov [bx], cl
    lea dx, niz
    mov ah, 0Ah
    int 21h
           
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h       
           
    lea bx, niz
    INC bx
	MOV cl, [bx]
	xor ch, ch
	
	ispisivanje:
		INC bx
		MOV dl, [bx]
		MOV ah, 02h
		INT 21h
	LOOP ispisivanje
    
    mov ax, 4C00h
    int 21h
end start
        