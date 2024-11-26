.MODEL small
.DATA
	str_source DB "Dobar dan svima.$"
	str_destination DB 1024 DUP ('$')
.STACK
.CODE
CopyStrA MACRO si, di, cx
	REP MOVSB
ENDM

CopyStrB MACRO si, di
LOCAL petlja:
LOCAL end_cpy:

	MOV dl, [si]
	CMP dl, '$'
	JE end_cpy
	CMP dl, 0
	JE end_cpy
	
	petlja:
		MOVSB
		
		MOV cx, 2
		MOV dl, [si]
		CMP dl, '$'
	LOOPNE petlja
	
	end_cpy:
	MOV dl, '$'
	MOV [di], dl
ENDM

Start:
	MOV ax, @DATA
	MOV ds, ax
	MOV es, ax
	
	LEA si, str_source
	LEA di, str_destination
	MOV cx, 17
	;CopyStrA si, di, cx	;Rješenje zadatka 11.a.
	CopyStrB si, di			;Rješenje zadatka 11.b.
	
	LEA dx, str_destination
	MOV ah, 09h
	INT 21h
	
	MOV ah, 4Ch
	INT 21h
END Start