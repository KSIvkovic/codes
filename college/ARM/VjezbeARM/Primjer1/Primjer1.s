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

	LDRB	r5, [r0],#1		/* u r6 prvi byte podataka 0x01 */
	STR		r5, [sp],#-4	/* na stog se stavlja r5 */
	LDRB	r5, [r0],#1
	STR		r5, [sp],#-4
	LDRB	r5, [r0],#1
	STR		r5, [sp],#-4
	LDRB	r5, [r0],#1
	STR		r5, [sp],#-4
	

stop:

	B	stop			/* program end and get into endless loop */


pod:
.word 			0x000f, 0x00ff, 0x0fff, 0xffff
.byte 			0x01, 0x02, 0x03,0x04

.end
