.MODEL small
.STACK
.CODE
Start:
  MOV ah, 01h
  INT 21h
  
  MOV dl, al
  MOV ah, 02h
  INT 21h
    
  MOV ax, 4C00h
  INT 21h
END Start