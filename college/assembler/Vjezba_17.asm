.MODEL small
.DATA
	broj DW 12888
.STACK
.CODE
Start:
	MOV ax, @DATA
	MOV ds, ax

	MOV cx, 16
	bispis:
		ROL broj, 1
		MOV dx, broj
		AND dx, 1
		ADD dl, '0'
		MOV ah, 02h
		INT 21h
	LOOP bispis

	MOV ax, 4C00h
	INT 21h
END Start