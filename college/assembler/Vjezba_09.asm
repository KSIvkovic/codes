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
NewLine MACRO
	MOV dl, 10
	MOV ah, 02h
	INT 21h
	MOV dl, 13
	MOV ah, 02h
	INT 21h
ENDM

UnosZ MACRO
	MOV ah, 01h
	INT 21h                      ;Prekid za unos znaka sa tastature
ENDM

IspisN MACRO bx, cx
LOCAL forp_i:
LOCAL end_forp_i:
  MOV si, 0
  forp_i:
    CMP si, cx
    JGE end_forp_i
      MOV dl, [bx][si]
      ADD dl, '0'                  ;Ispis znaka iz niza
      MOV ah, 02h
      INT 21h
      
      MOV dl, ' '                  ;Ispis razmaka - space
      MOV ah, 02h
      INT 21h
      
      INC si
      JMP forp_i
    end_forp_i:
ENDM

IspisNiza MACRO bx, cx
LOCAL forp_ia:
LOCAL end_forp_ia:
  MOV si, 0
  forp_ia:
    CMP si, cx
    JGE end_forp_ia
      MOV dl, [bx][si]
      ADD dl, '0'                  ;Ispis znaka iz niza
      MOV ah, 02h
      INT 21h
      
      INC si
      JMP forp_ia
    end_forp_ia:
ENDM

FindMin PROC
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

	RET
FindMin ENDP

FindMax PROC
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

	RET
FindMax ENDP

Sortiraj PROC
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

	RET
Sortiraj ENDP

Start:
	MOV ax, @DATA
	MOV ds, ax
  
	; a) Unesi 10 jednoznamenkastih brojeva
	MOV si, 0
	forp_u:
		CMP si, 10
		JGE end_forp_u

		UnosZ
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
      NewLine
      JMP forp_u
    end_forp_u:

    NewLine
  
	; b) Ispis svih znamenki u nizu s razmakom izmeðu njih
	MOV bx, OFFSET niz_br
	MOV cx, 10
	IspisN bx, cx
	NewLine
  
	MOV dx, OFFSET minelmsg
	MOV ah, 09h
	INT 21h
	; c) Pronaði najmanji element i ispisi ga
	CALL FindMin
	NewLine  

	MOV dx, OFFSET maxelmsg
	MOV ah, 09h
	INT 21h
	; d) Pronaði najveci element i ispisi ga
	CALL FindMax
	NewLine
    
	MOV dx, OFFSET sortmsg
	MOV ah, 09h
	INT 21h
	; d) Sortitaj niz i ispiši ga na ekran
	CALL Sortiraj



	MOV bx, OFFSET niz_br
	MOV cx, 10
	IspisNiza bx, cx
       
  MOV ax, 4C00h
  INT 21h
END Start