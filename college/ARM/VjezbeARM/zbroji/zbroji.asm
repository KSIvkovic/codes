.global _start

.text

_start:	

	adr	r0, podaci
	LDR	r1, [r0], #4
	LDR r2, [r0], #4
	BL  zbroji
	ADD r3, r3, #0
zbroji:
	ADD r3, r1, r2
	MOV r15, r14


stop:

	B	stop
	
podaci:
.word	30, 40			

.end
