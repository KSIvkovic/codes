.global _start
.text

_start:	
	adr	r0, pod
	MOV	r10, #0xF0
	MOV	r10, r10, LSL #24
poc:
	LDR r1, [r0],#4
	cmp	r1, r10
	beq	kraj
	cmp	r1,#0
	blt	poc
	BL  zamijeni
	b	poc
kraj:
	ADD r8, r8, #0
	
zamijeni:
	MOV r2, #0xFF
	MOV	r3, r2, LSL #24
	MOV	r4,	r2, LSL #16
	ORR	r4, r4, r2, LSL #8
	AND	r5, r1, r2
	MOV r5, r5, LSL #24
	AND r6, r1, r3
	MOV r6, r6, LSR #24
	AND r7, r1, r4
	ORR r8, r5, r6
	ORR r8,r8, r7
	MOV r15, r14
	
stop:
	B	stop
pod:
.word	0x00BBCCDD, 0x00112233, 0xaa112233, 0xf0000000

.end
