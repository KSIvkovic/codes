.MODEL small
.DATA
	STR_LENGTH EQU 30
	BUFF_LENGTH EQU STR_LENGTH + 3
	MyString DB BUFF_LENGTH DUP (0)
	Coder_Mask DB 128
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

DeKodiraj MACRO bx, ah
LOCAL kodiranje

	INC bx
	MOV cl, [bx]
	XOR ch, ch
	
	kodiranje:
		INC bx
		MOV dl, [bx]
		XOR dl, ah
		MOV [bx], dl
	LOOP kodiranje
ENDM

IspisiString MACRO bx
LOCAL ispisivanje

	INC bx
	MOV cl, [bx]
	XOR ch, ch
	
	ispisivanje:
		INC bx
		MOV dl, [bx]
		MOV ah, 02h
		INT 21h
	LOOP ispisivanje
ENDM

Start:
	MOV ax, @DATA
	MOV ds, ax
	
	LEA bx, MyString
	MOV cl, BUFF_LENGTH
	MOV [bx], cl
	LEA dx, MyString
	MOV ah, 0Ah
	INT 21h
	
	NewLine
	LEA bx, MyString
	IspisiString bx
	
	LEA bx, MyString
	MOV ah, Coder_Mask
	DeKodiraj bx, ah
	
	NewLine
	LEA bx, MyString
	IspisiString bx
	
	NewLine
	
	LEA bx, MyString
	MOV ah, Coder_Mask
	DeKodiraj bx, ah
	
	NewLine
	LEA bx, MyString
	IspisiString bx
	
	MOV ax, 4C00h
	INT 21h
END Start