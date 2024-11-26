.MODEL small
.STACK
.CODE
UnosZ MACRO
	MOV ah, 01h
	INT 21h
ENDM

Start:
	MOV cx, 5
	petlja:
		UnosZ
		
		CMP al, '3'
	LOOPNE petlja
	
	MOV ax, 4C00h
	INT 21h
END Start