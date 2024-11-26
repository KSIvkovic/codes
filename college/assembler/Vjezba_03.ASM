.MODEL small
.STACK
.CODE
Start:
  MOV dl, '3'
  MOV ah, 02h
  INT 21h
    
  MOV ax, 4C00h
  INT 21h
END Start