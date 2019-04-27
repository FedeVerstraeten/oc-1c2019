#include "common.h" 
  .abicalls
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,48,ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,48
	.cprestore 16
	sw	ra,40(sp)
	sw	$fp,36(sp)
	sw	gp,32(sp)
	move	$fp,sp
	sw	a0,48($fp)
	sw	a1,52($fp)
	li	v0,1			# 0x1
	sw	v0,24($fp)
	move	a0,zero
	li	a1,1			# 0x1
	la	t9,dos2unix
	jal	ra,t9
	sw	v0,24($fp)
	lw	v0,24($fp)
	beq	v0,zero,L6
	lw	v0,24($fp)
	sll	v1,v0,2
	la	v0,errmsg
	addu	v0,v1,v0
	lw	a0,0(v0)
	la	t9,mystrlen
	jal	ra,t9
	move	a2,v0
	lw	v0,24($fp)
	sll	v1,v0,2
	la	v0,errmsg
	addu	v0,v1,v0
	li	a0,2			# 0x2
	lw	a1,0(v0)
	la	t9,write
	jal	ra,t9
	li	v0,1			# 0x1
	sw	v0,28($fp)
	b	L5
L6:
	sw	zero,28($fp)
L5:
	lw	v0,28($fp)
	move	sp,$fp
	lw	ra,40(sp)
	lw	$fp,36(sp)
	addu	sp,sp,48
	j	ra
	.end	main
	.size	main, .-main
