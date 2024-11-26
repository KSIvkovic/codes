.equ	stack_top, 0x1000			/* vrh stoga na adresi 0x1000*/
.global _start

.text

_start:						/* Poèetak programa */
	MOV		sp, #stack_top	/* postavlja se stack pointer na vrh stoga */
	adr		r0, pod			/* stavlja se u ro adresa podataka */
	LDR		r1, [r0],#4		/* u r1 prvi podatak iz memorije 30 */
	LDR		r2, [r0],#4		/* u r2 drugi podatak iz memorije 5 */

	STR		r1, [sp],#-4	/* na stog se stavlja r5 */
	STR		r2, [sp],#-4
	
	BL		podijeli
	
	LDR		r3, [sp, #4]!


stop:

	B	stop			/* program end and get into endless loop */

podijeli:
	LDR		r4, [sp, #4]!
	LDR		r3, [sp, #4]!
	MOV		r5, #0
petlja:
	SUBS	r3, r3, r4
	BLE		kraj
	ADD		r5, r5, #1
	B		petlja	
kraj:
	STR		r5, [sp],#-4
	MOV		r15, r14
	


pod:
.word 			0x0020, 0x0005


.end