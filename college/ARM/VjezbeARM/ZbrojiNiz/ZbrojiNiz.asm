.global _start
.text

_start:	
	adr	r0, pod
	MOV	sp, #0x1000
	MOV	r2, #0x10
	MOV	r3, #0

poc:
	cmp	r2, #0
	blt	kraj
	SUB	r2, r2, #4
	LDR r1, [r0],#4
	STR	r3, [sp],#-4
	STR	r1, [sp],#-4
	BL  zbroji
	LDR	r3, [sp, #4]!
	b	poc
kraj:
	ADD r5, r5, #0
	B	stop
	
zbroji:
	LDR r5, [sp,#4]!
	LDR r4, [sp,#4]!
	ADD	r5, r5, r4
	STR	r5, [sp],#-4
	MOV r15, r14
	
stop:
	B	stop
pod:
.word	0x00BBCCDD, 0x00112233, 0xaa112233, 0x000000003, 0x00BBCCDD, 0x00112233, 0xaa112233, 0x000000003 

.end