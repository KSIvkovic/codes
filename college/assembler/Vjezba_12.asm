.MODEL small
.DATA
	broj1 DD 0A12BC12h
	broj2 DD 0112BC12h
.STACK
.CODE
LoadNumbers MACRO
	LEA si, broj1
	MOV bx, [si]
	INC si
	INC si
	MOV ax, [si]
	
	LEA si, broj2
	MOV dx, [si]
	INC si
	INC si
	MOV cx, [si]
ENDM

Start:
	MOV ax, @DATA
	MOV ds, ax
	
	LoadNumbers
	
	ADD bx, dx
	ADC ax, cx
	
	LoadNumbers
	
	SUB bx, dx
	SBB ax, cx
	
	MOV ax, 4C00h
	INT 21h
END Start