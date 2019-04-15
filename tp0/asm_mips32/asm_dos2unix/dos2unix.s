	.file	1 "dos2unix.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.text
	.align	2
	.globl	dos2unix
	.ent	dos2unix
dos2unix:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	sh	$zero,24($fp)
	sw	$zero,32($fp)
	lw	$a0,56($fp)
	addu	$a1,$fp,24
	li	$a2,1			# 0x1
	la	$t9,read
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L18
	li	$v0,2			# 0x2
	sw	$v0,36($fp)
	b	$L17
$L18:
	.set	noreorder
	nop
	.set	reorder
$L19:
	lw	$v0,32($fp)
	bgtz	$v0,$L21
	b	$L20
$L21:
	addu	$v0,$fp,25
	lw	$a0,56($fp)
	move	$a1,$v0
	li	$a2,1			# 0x1
	la	$t9,read
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L22
	li	$v0,2			# 0x2
	sw	$v0,36($fp)
	b	$L17
$L22:
	lw	$v0,32($fp)
	bne	$v0,$zero,$L23
	lw	$a0,60($fp)
	addu	$a1,$fp,24
	li	$a2,1			# 0x1
	la	$t9,write
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L24
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
	b	$L17
$L24:
	sw	$zero,36($fp)
	b	$L17
$L23:
	lbu	$v1,24($fp)
	li	$v0,13			# 0xd
	bne	$v1,$v0,$L25
	lbu	$v1,25($fp)
	li	$v0,10			# 0xa
	bne	$v1,$v0,$L25
	addu	$v0,$fp,25
	lw	$a0,60($fp)
	move	$a1,$v0
	li	$a2,1			# 0x1
	la	$t9,write
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L26
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
	b	$L17
$L26:
	lw	$a0,56($fp)
	addu	$a1,$fp,24
	li	$a2,1			# 0x1
	la	$t9,read
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L19
	li	$v0,2			# 0x2
	sw	$v0,36($fp)
	b	$L17
$L25:
	lw	$a0,60($fp)
	addu	$a1,$fp,24
	li	$a2,1			# 0x1
	la	$t9,write
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L29
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
	b	$L17
$L29:
	lbu	$v0,25($fp)
	sb	$v0,24($fp)
	b	$L19
$L20:
	lw	$v0,32($fp)
	blez	$v0,$L30
	addu	$v0,$fp,25
	lw	$a0,60($fp)
	move	$a1,$v0
	li	$a2,1			# 0x1
	la	$t9,write
	jal	$ra,$t9
	sw	$v0,32($fp)
$L30:
	lw	$v1,32($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L31
	li	$v0,1			# 0x1
	sw	$v0,36($fp)
	b	$L17
$L31:
	lw	$v0,32($fp)
	sw	$v0,36($fp)
$L17:
	lw	$v0,36($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	dos2unix
	.size	dos2unix, .-dos2unix
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
