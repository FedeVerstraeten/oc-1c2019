#include "common.h"	
  .abicalls
	.text
	.align	2
	.globl	unix2dos
	.ent	unix2dos
unix2dos:
	.frame	$fp,56,ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,56
	.cprestore 16
	sw	ra,48(sp)
	sw	$fp,44(sp)
	sw	gp,40(sp)
	move	$fp,sp
	sw	a0,56($fp)
	sw	a1,60($fp)
	sb	zero,24($fp)
	li	v0,13			# 0xd
	sb	v0,25($fp)
	sw	zero,28($fp)
	lw	a0,56($fp)
	addu	a1,$fp,24
	li	a2,1			# 0x1
	la	t9,read
	jal	ra,t9
	sw	v0,28($fp)
	lw	v0,28($fp)
	bgtz	v0,L18
	li	v0,3			# 0x3
	sw	v0,32($fp)
	b	L17
L18:
	.set	noreorder
	nop
	.set	reorder
L19:
	lw	v0,28($fp)
	bgtz	v0,L21
	b	L20
L21:
	lbu	v1,24($fp)
	li	v0,10			# 0xa
	bne	v1,v0,L22
	addu	v0,$fp,25
	lw	a0,60($fp)
	move	a1,v0
	li	a2,1			# 0x1
	la	t9,write
	jal	ra,t9
	sw	v0,28($fp)
	lw	a0,60($fp)
	addu	a1,$fp,24
	li	a2,1			# 0x1
	la	t9,write
	jal	ra,t9
	sw	v0,28($fp)
	b	L23
L22:
	lw	a0,60($fp)
	addu	a1,$fp,24
	li	a2,1			# 0x1
	la	t9,write
	jal	ra,t9
	sw	v0,28($fp)
L23:
	lw	a0,56($fp)
	addu	a1,$fp,24
	li	a2,1			# 0x1
	la	t9,read
	jal	ra,t9
	sw	v0,28($fp)
	lw	v0,28($fp)
	bgtz	v0,L19
L20:
	lw	v1,28($fp)
	li	v0,-1			# 0xffffffffffffffff
	bne	v1,v0,L25
	li	v0,3			# 0x3
	sw	v0,32($fp)
	b	L17
L25:
	sw	zero,32($fp)
L17:
	lw	v0,32($fp)
	move	sp,$fp
	lw	ra,48(sp)
	lw	$fp,44(sp)
	addu	sp,sp,56
	j	ra
	.end	unix2dos
	.size	unix2dos, .-unix2dos

