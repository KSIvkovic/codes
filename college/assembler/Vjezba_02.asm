.MODEL small
.DATA
  poruka1 DB "Dobar dan svima.$"
  poruka2 DB "Koliko vas ima.$"
.STACK
.CODE
Start:
  MOV ax, @DATA
  MOV ds, ax
  
  MOV dx, OFFSET poruka1
  MOV ah, 09h
  INT 21h
  
  MOV dl, 10
  MOV ah, 02h
  INT 21h
  MOV dl, 13
  MOV ah, 02h
  INT 21h
    
  MOV dx, OFFSET poruka2
  MOV ah, 09h
  INT 21h
    
  MOV ax, 4C00h
  INT 21h
END Start