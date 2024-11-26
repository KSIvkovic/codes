.MODEL small
.STACK
.CODE
Start:
  MOV cx, 0
  for_p:
    CMP cx, 10
    JGE end_for_p
    
    MOV dl, '3'
    MOV ah, 02h
    INT 21h
    
    INC cx
    JMP for_p
  end_for_p:
  
  MOV ax, 4C00h
  INT 21h
END Start