.global _start

.text

_start:						/* Poèetak programa */
	MOV		r1, #0xAA
	MOV		r1, r1, LSL #8
	ORR		r1, r1, #0xCC
	
	adr		r0, pod
	LDR		r1, [r0]
	
	MOV		r2, #0xFF
	AND		r3, r1, r2
	MOV		r2, r2, LSL #8	
	AND		r4, r1, r2
	MOV		r3, r3, LSL #8
	MOV		r4, r4, LSR #8
	ORR		r5, r3, r4


pod:
.word 			0x0000EECC

.end