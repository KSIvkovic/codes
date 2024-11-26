.global _start
.text

_start:	
	adr	r0, pod
	MOV	r1, #0
	MOV	r2, #0
	MOV	r11, #0x0A00
	MOV	r12, #0x1000

poc1:
	LDR r3, [r0],#4
	CMP	r3, #0
	BEQ	kraj1
	CMP	r3, #0
	BLT	negativan
	ADD	r1, r1, #1
	STR	r3, [r11], #4
	b	poc1
negativan:
	ADD	r2, r2, #1
	STR	r3, [r12], #4
	b	poc1
kraj1:
	MOV	r11, #0x0A00
	adr	r0, pod
poc2:
	CMP	r1, #0
	BEQ	kraj2
	LDR	r3, [r11], #4
	STR	r3, [r0], #4
	SUB	r1, r1, #1
	B	poc2
kraj2:

	MOV	r12, #0x1000
poc3:
	CMP	r2, #0
	BEQ	kraj3
	LDR	r3, [r12], #4
	STR	r3, [r0], #4
	SUB	r2, r2, #1
	B	poc3
kraj3:	
	
stop:
	B	stop
pod:
.word	-1, -3, 5, 8, -5, 6, 4,-9, 10, 2, 0

.end