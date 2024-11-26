.MODEL small
.DATA
  niz_br DB 10 DUP (0)
  fbroj DB 0
  ;Messages
  errormsg_unos DB "Ponovite unos.$"
  minelmsg DB "Najmanji element niza je: $"
  maxelmsg DB "Najveci  element niza je: $"
  sortmsg DB "Sortirani niz: $"
.STACK
.CODE
Start:
  MOV ax, @DATA
  MOV ds, ax
  
  ; a) Unesi 10 jednoznamenkastih brojeva
  MOV si, 0
  forp_u:
    CMP si, 10
    JGE end_forp_u

      MOV ah, 01h
      INT 21h                      ;Prekid za unos znaka sa tastature

      CMP al, '0'
      JL pogresan_unos             ;Uneseni znak nije znamenka; znak < '0'

      CMP al, '9'
      JG pogresan_unos             ;Uneseni znak nije znamenka; znak > '9'

      SUB al, '0'                  ;Pretvorba iz znakova u brojeve

      MOV niz_br[si], al           ;Spremiti kao broj
      
      INC si
      JMP forp_u

    pogresan_unos:
      MOV dx, OFFSET errormsg_unos
      MOV ah, 09h
      INT 21h
      
      MOV dl, 10
      MOV ah, 02h
      INT 21h
      MOV dl, 13
      MOV ah, 02h
      INT 21h
      JMP forp_u
    end_forp_u:

;Novi red
  MOV dl, 10
  MOV ah, 02h
  INT 21h
  MOV dl, 13
  MOV ah, 02h
  INT 21h
  
  ; b) Ispis svih znamenki u nizu s razmakom izmeðu njih
  MOV si, 0
  forp_i:
    CMP si, 10
    JGE end_forp_i
      MOV dl, niz_br[si]
      ADD dl, '0'                  ;Ispis znaka iz niza
      MOV ah, 02h
      INT 21h
      
      MOV dl, ' '                  ;Ispis razmaka - space
      MOV ah, 02h
      INT 21h
      
      INC si
      JMP forp_i
    end_forp_i:

;Novi red
  MOV dl, 10
  MOV ah, 02h
  INT 21h
  MOV dl, 13
  MOV ah, 02h
  INT 21h
  
  MOV dx, OFFSET minelmsg
  MOV ah, 09h
  INT 21h
  
  ; c) Pronaði najmanji element i ispisi ga
  MOV si, 0
  MOV dl, niz_br[si]              ;Pretpostavljamo da je minimalni element na indexu 0
  INC si
  forp_minel:
    CMP si, 10
    JGE end_forp_minel
      MOV al, niz_br[si]
      
      CMP dl, al
      JLE not_minel               ;Ukoliko smo našli manji element tada je taj element najmanji
        MOV dl, al
      not_minel:

      INC si
      JMP forp_minel
    end_forp_minel:
    
  ADD dl, '0'
  MOV ah, 02h
  INT 21h

;Novi red
  MOV dl, 10
  MOV ah, 02h
  INT 21h
  MOV dl, 13
  MOV ah, 02h
  INT 21h
  
  MOV dx, OFFSET maxelmsg
  MOV ah, 09h
  INT 21h
  
  ; c) Pronaði najveci element i ispisi ga
  MOV si, 0
  MOV dl, niz_br[si]              ;Pretpostavljamo da je maksimalni element na indexu 0
  INC si
  forp_maxel:
    CMP si, 10
    JGE end_forp_maxel
      MOV al, niz_br[si]
      
      CMP dl, al
      JGE not_maxel               ;Ukoliko smo našli veæi element tada je taj element najveæi
        MOV dl, al
      not_maxel:

      INC si
      JMP forp_maxel
    end_forp_maxel:
  
  ADD dl, '0'  
  MOV ah, 02h
  INT 21h

  ;Novi red
  MOV dl, 10
  MOV ah, 02h
  INT 21h
  MOV dl, 13
  MOV ah, 02h
  INT 21h
    
  ; d) Sortitaj niz i ispiši ga na ekran
  MOV si, 0
  forp_sorti:
    CMP si, 9
    JGE end_forp_sorti            ;Vanjska petlja - 0 do N-1
    
      MOV di, si
      INC di                      ; Unutarnja petlja - 1 do N
      forp_sortj:
        CMP di, 10
        JGE end_forp_sortj
        
        MOV al, niz_br[si]
        MOV ah, niz_br[di]
        CMP al, ah                ; Ukoliko je prvi element manji od sljedeæeg
        JGE not_sort              ; zamijeni im pozicije - padajuæi sortiran niz
          MOV niz_br[si], ah
          MOV niz_br[di], al
        not_sort:
        INC di
        JMP forp_sortj
      end_forp_sortj:
      
      INC si
      JMP forp_sorti
  end_forp_sorti:

  MOV dx, OFFSET sortmsg
  MOV ah, 09h
  INT 21h  
  
  MOV si, 0
  forp_i2:
    CMP si, 10
    JGE end_forp_i2
      MOV dl, niz_br[si]
      ADD dl, '0'                 ;Ispis znaka iz niza
      MOV ah, 02h
      INT 21h
      
      INC si
      JMP forp_i2
    end_forp_i2:
       
  MOV ax, 4C00h
  INT 21h
END Start