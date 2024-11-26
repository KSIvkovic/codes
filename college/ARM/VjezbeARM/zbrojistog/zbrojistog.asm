.global _start
.equ	stack_top, 0x1000

.text

_start:	
	MOV	sp, #stack_top
	adr	r0, podaci
	LDR	r1, [r0], #4
	LDR	r2, [r0], #4
	STR	r1, [sp], #-4
	STR	r2, [sp], #-4	
	BL	zbroji
	LDR	r3, [sp]
	B	stop
	
zbroji:
	STR	r1, [sp], #-4
	STR	r2, [sp], #-4
	LDR	r2, [sp,#16]
	LDR	r1, [sp,#12]			
	ADD	r3, r1, r2
	LDR	r2, [sp,#4]!
	LDR	r1, [sp,#4]!
	STR	r3, [sp,#8]!
	MOV	r15, r14


stop:

	B	stop
	
podaci:
.word	0x30, 0x40			

.end