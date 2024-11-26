.MODEL small
.DATA
	broj DW 7F3h
	broj_niz DB 10 DUP (0)
.STACK
.CODE
Start:
	MOV ax, @DATA
	MOV ds, ax
	
	MOV ax, broj
	MOV dl, 10
	MOV si, 0
	petlja:
		DIV dl
		
		MOV broj_niz[si], ah
		XOR ah, ah
		
		INC si
		MOV cx, 2
		CMP ax, 0
	LOOPNE petlja
	
	ispis:
		DEC si
		MOV dl, broj_niz[si]
		ADD dl, '0'
		MOV ah, 02h
		INT 21h
		
		CMP si, 0
	JG ispis
	
	MOV ax, 4C00h
	INT 21h
END Start
		
		
	
	