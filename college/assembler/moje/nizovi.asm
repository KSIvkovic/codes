.MODEL
.DATA
    niz db 10 DUP (0) 
    minstr db "Minimalni element: $"
    maxstr db "Maximalni element: $"  
    sortstr db "Sortirani niz: $" 
    error db "Pogresan unos! Ponovite.$"
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

minimum PROC
     mov si, 0
    mov dl, niz[si]
    inc si 
    min:
        cmp si, 10
        jge min_kraj
        
        mov dh, niz[si]
        cmp dl, dh
        jle nemin
        mov dl, dh
    nemin:
        inc si
        jmp min
    min_kraj:
    add dl, '0'
    mov ah, 02h
    int 21h
RET
minimum ENDP

maximum PROC
     mov si, 0
    mov dl, niz[si]
    inc si 
    max:
        cmp si, 10
        jge max_kraj
        
        mov dh, niz[si]
        cmp dl, dh
        jge nemax
        mov dl, dh
    nemax:
        inc si
        jmp max
    max_kraj:
    add dl, '0'
    mov ah, 02h
    int 21h
RET
maximum ENDP

sortiraj PROC
    mov si, 0
    sorti:
        cmp si, 9
        jge sorti_kraj
        
        mov di, si
        inc di
        sortj:
                cmp di, 10
                jge sortj_kraj
                
                mov ah, niz[si]
                mov al, niz[di]
                
                cmp ah, al
                jle nesort
                mov niz[si], al
                mov niz[di], ah
                
            nesort:
                inc di
                jmp sortj
        sortj_kraj: 
            inc si
            jmp sorti
    sorti_kraj:
RET
sortiraj ENDP

ispis MACRO bx, cx
    LOCAL ispis, ispis_kraj
    mov si, 0
    ispis:
        cmp si, cx
        jge ispis_kraj
        
        mov dl, [bx][si]
        add dl, '0'
        mov ah, 02h
        int 21h
        
        mov dl, 32
        mov ah, 02h
        int 21h
        
        inc si
        jmp ispis
    ispis_kraj:
ENDM

unos_znaka MACRO 
    mov ah, 01h
    int 21h
ENDM

start:
    mov ax, @data
    mov ds, ax
    
    mov si, 0
    unos:
        cmp si, 10
        jge unos_kraj
        
        unos_znaka
        
        cmp al, '0'
        jl pogresan_unos
        
        cmp al, '9'
        jg pogresan_unos
        
        jmp unosenje
        
        pogresan_unos:
        novired
        lea dx, error
        mov ah, 09h
        int 21h
        jmp unos
        
        unosenje:
        sub al, '0'
        mov niz[si], al
        inc si
        jmp unos
    unos_kraj:
    
    novired
    
    lea bx, niz
    mov cx, 10
    ispis bx, cx
    
    novired
    
    lea dx, minstr
    mov ah, 09h
    int 21h
    
    call minimum
    
    novired
    
    lea dx, maxstr
    mov ah, 09h
    int 21h
    
    call maximum
    
    novired
    
    lea dx, sortstr
    mov ah, 09h
    int 21h
    
    call sortiraj
    
    lea bx, niz
    mov cx, 10
    ispis bx, cx
                 
    mov ax, 4C00h
    int 21h
end start
