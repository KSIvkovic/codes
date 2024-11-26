.equ	broj, 0x400

.global _start

.text

_start:
	MOV		R0, #0		/* r = 0 */
	MOV		R1, #1		/* s = 1 */
	MOV		R2, #broj	/* broj èiji korjen se traži */
	
petlja:
	ADD		R0, R0, #1
	ADD		R1, R1, R0, LSL #1
	ADD		R1, R1, #1
	CMP		R1, R2
	BLE		petlja
	
stop:

	B	stop	
	