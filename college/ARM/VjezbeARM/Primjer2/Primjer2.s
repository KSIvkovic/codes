.equ	adresa, 0x2000				/* adresa bloka u memoriji */
.equ	stack_top, 0x1000			/* vrh stoga na adresi 0x1000*/
.global _start

.text

_start:						/* Poèetak programa */
	MOV		sp, #stack_top	/* postavlja se stack pointer na vrh stoga */
	adr		r0, pod			/* stavlja se u ro adresa podataka */
	LDR		r1, [r0],#4		/* u r1 prvi podatak iz memorije 0x000F */
	LDR		r2, [r0],#4		/* u r2 drugi podatak iz memorije 0x00FF */
	LDR		r3, [r0],#4		/* u r3 treci podatak iz memorije 0x0FFF */
	LDR		r4, [r0],#4		/* u r4 cetvrti podatak iz memorije 0xFFFF */

	STR		r1, [sp],#-4	/* Prvi operand na stog */
	STR		r2, [sp],#-4	/* Drugi operand na stog */
	STR		r3, [sp],#-4	/* Treæi operand na stog */
	STR		r4, [sp],#-4	/* Èetvrti operand na stog */
	
	BL		zbroji
	
	LDR		r1, [sp, #4]!	/* rezultat u r1 */
	
stop:

	B	stop			/* program end and get into endless loop */	
	
zbroji:
	LDR		r1, [sp, #4]!	/* u r1 èetvrti operand */
	LDR		r2, [sp, #4]!	/* u r1 èetvrti operand */
	LDR		r3, [sp, #4]!	/* u r1 èetvrti operand */
	LDR		r4, [sp, #4]!	/* u r1 èetvrti operand */
	ADD		r5, r1, r2
	ADD		r5, r5, r3
	ADD		r5, r5, r4
	STR		r5, [sp],#-4
	
	MOV		r15, r14
	


pod:
.word 			0x000A, 0x0014, 0x001D, 0x0028

.end
