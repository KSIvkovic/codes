.MODEL small
.STACK
.CODE
Start:
  MOV bx, 5
  MOV ax, bx
      
  MOV ax, 4C00h
  INT 21h
END Start