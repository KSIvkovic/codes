.MODEL small
.STACK
.CODE
Start:
  
  MOV ax, 8
  
  CMP ax, 10
  JLE else_if
  
    MOV bx, 0
    JMP end_if_else
  else_if:
    MOV bx, 0FFFFh
    
  end_if_else:
    
  MOV ax, 4C00h
  INT 21h
END Start