.equ stack, 0x1000

.global _start

.text

_start:	
	adr		R0, pod
	mov		sp, #stack
	
	mov		R1, #0xAA
	mov		R2, R1, LSL #8
	mov		R1, #0x55
	ORR		R3, R1, R2
	ORR		R3, R3, R1, LSL #16
	
stop:
	B		stop

pod:
