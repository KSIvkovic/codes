.MODEL small
.DATA
  niz1 DB 6 DUP ('$')
.STACK
.CODE
Start:
  MOV ax, @DATA
  MOV ds, ax
  
  MOV si, 0
  forp_u:
    CMP si, 5
    JGE end_forp_u
    
      MOV ah, 01h
      INT 21h
      
      MOV niz1[si], al
      
      INC si
      JMP forp_u
    end_forp_u:
  
  MOV niz1[si], '$'
  
  MOV dl, 10
  MOV ah, 02h
  INT 21h
  MOV dl, 13
  MOV ah, 02h
  INT 21h
  
  MOV dx, OFFSET niz1
  MOV ah, 09h
  INT 21h
  
  MOV ax, 4C00h
  INT 21h
END Start