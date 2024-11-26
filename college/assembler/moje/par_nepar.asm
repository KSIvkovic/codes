.MODEL small
.DATA 
    niz db 10 DUP (0)
    par db 10 DUP (' ')
    nepar db 10 DUP (' ')
.STACK
.CODE
novired MACRO 
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
ENDM

ispis MACRO bx, cx 
    LOCAL print, ispisi
    print:
        mov dl, [bx]
        
        cmp dl, ' '
        je ispisi
        
        add dl, '0'
    ispisi:
        mov ah, 02h
        int 21h
        
        mov dl, 32
        mov ah, 02h
        int 21h
        
        inc bx
        loop print
ENDM 

parni_niz MACRO bx, cx, di
    LOCAL parni, nijepar
    parni:
        mov al, [bx]
        mov ah, al
        and al, 1
        cmp al, 0
        jne nijepar
        mov [di], ah
        inc di
    nijepar:
        inc bx
        loop parni
ENDM

neparni_niz MACRO bx, cx, di
    neparni:
        mov al, [bx]
        mov ah, al
        and al, 1
        cmp al, 0
        je nijenepar
        mov [di], ah
        inc di
    nijenepar:
        inc bx
        loop neparni
ENDM
    
start:
    mov ax, @data
    mov ds, ax
    
    mov cx, 10
    lea bx, niz
    unos:
        mov ah, 01h
        int 21h
        
        cmp al, '0'
        jl unos
        
        cmp al, '9'
        jg unos
        
        sub al, '0'
        mov [bx], al
        inc bx
        loop unos
        
    novired
        
    mov cx, 10
    lea bx, niz
    ispis bx, cx
        
    mov cx, 10
    lea bx, niz
    lea di, par
    parni_niz bx, cx, di
        
    novired 
        
    mov cx, 10
    lea bx, par
    ispis bx, cx  
    
    novired
    
    mov cx, 10
    lea bx, niz
    lea di, nepar
    neparni_niz bx, cx, di 
        
    mov cx, 10
    lea bx, nepar
    ispis bx, cx
        
    mov ax, 4C00h
    int 21h
        

end start 
        