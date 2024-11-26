.MODEL small
.DATA
	niz DB 10 DUP (0)
	maska_0 DB 1
	maska_2 DB 4
	maska_4 DB 16
	maska_6 DB 64
	maska_A DB 85
.STACK
.CODE

NewLine MACRO
	MOV dl, 10
	MOV ah, 02h
	INT 21h
	MOV dl, 13
	MOV ah, 02h
	INT 21h
ENDM

CountBitStates MACRO bx, cx, ah
LOCAL petlja
LOCAL preskoci
	
	MOV si, 0
	petlja:
		MOV al, [bx]
		AND al, ah
		
		CMP al, ah
		JNE preskoci
			INC si
		preskoci:
		
		INC bx
	LOOP petlja
	
	MOV dx, si
	ADD dl, '0'
	MOV ah, 02h
	INT 21h
ENDM

Start:
	MOV ax, @DATA
	MOV ds, ax
	
	MOV cx, 10
	LEA bx, niz
	unos:
		MOV ah, 01h
		INT 21h
		
		MOV [bx], al
		
		INC bx
	LOOP unos
	
	Newline
	LEA bx, niz
	MOV cx, 10
	MOV ah, maska_0
	CountBitStates bx, cx, ah
	
	Newline
	LEA bx, niz
	MOV cx, 10
	MOV ah, maska_2
	CountBitStates bx, cx, ah
	
	Newline
	LEA bx, niz
	MOV cx, 10
	MOV ah, maska_4
	CountBitStates bx, cx, ah
	
	Newline
	LEA bx, niz
	MOV cx, 10
	MOV ah, maska_6
	CountBitStates bx, cx, ah
	
	Newline
	LEA bx, niz
	MOV cx, 10
	MOV ah, maska_A
	CountBitStates bx, cx, ah
	
	MOV ah, 4Ch
	INT 21h
END Start
