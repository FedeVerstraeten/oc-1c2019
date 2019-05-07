#include "common.h"
#include "messages.h"	

#define SIZE_SF 24
#define OFFSET_BUFFER 36
# ABA caller.
#define OUTFD 28
#define INTFD 24

# Saved-registers area (SRA).
#define FP 20
#define GP 16

# Local and Temporary Area (LTA).
#define PADDING_0 12
#define A_BYTE 8
#define CONTROL_CHAR 4
#define BUFFER 0

.abicalls
	.text
	.align	2
	.globl	unix2dos
	.ent	unix2dos

unix2dos:
	# Debugger metadata.
	.frame	$fp,SIZE_SF,ra
	# Pipeline magic.	
	.set	noreorder	
	.cpload	t9		
	.set	reorder
	# Allocate memory for the stack.		
	subu	sp,sp,SIZE_SF
	# SRA beginning area.
	.cprestore GP

	# Save the callee-saved registers used by the caller in the SRA.
	sw  $fp,FP(sp)
	sw  gp, GP(sp)
	# We must set the $fp to the beginning of the stack.
	move $fp,sp

	# Now we save the arguments that were loaded by the caller
	# in the area reserved by the caller.
	sw  a0,INTFD($fp)
	sw  a1,OUTFD($fp)

	# Add local parameters	
	sw	zero,OFFSET_BUFFER($fp)
	#// Cargo en v0 el puntero al buffer.
	#lw	v0,OFFSET_BUFFER($fp)
	#// Cargo en v0 el 1er byte del buffer.
	#lbu	v0,0(v0)
	#// Guardo el 1er byte en el stack frame
	#sb	v0,BUFFER($fp)
	#// Cargo nuevamente la dirección del buffer.
	#lw	v0,OFFSET_BUFFER($fp)

	li	v0,ASCII_CR
	sb	v0,CONTROL_CHAR($fp)
	sw	zero,A_BYTE($fp)
	
	# Read one character using syscall read
	lw	a0,INTFD($fp)
	addu      a1, $fp, BUFFER
	li	a2,1
	li	v0,SYS_read
        syscall
	#jal	ra,t9

	# If a_byte minus 1
	sw	v0,A_BYTE($fp)
	bgez	v0,while_loop
	nop
	li	v0,ERROR_NUMBER_READ_FILE
	b	exit_function
	nop
while_loop:
	lw	v0,A_BYTE($fp)
	beq	v0,ASCII_LF,equal_LF
	nop
	sw	v0,A_BYTE($fp)
	b	exit_while
	nop
equal_LF:    #If buffer equal to LF
	lw	v1,BUFFER($fp)
	li	v0,ASCII_LF
	bne	v1,v0,else_buffer
	nop
	lw	v0,CONTROL_CHAR
	lw	a0,OUTFD($fp)
	move	a1,v0
	li	a2,1
	li	v0,SYS_write
        syscall
	#jal	ra,t9

	lw	a0,OUTFD($fp)
	#lw      a1, BUFFER($fp)
	lw      a1, BUFFER($fp)
	li	a2,1
	li	v0,SYS_write
        syscall
	#jal	ra,t9
	#sw	v0,CONTROL_CHAR($fp)
	b	read_buffer
	nop
else_buffer:    # If not equal to LF
	lw	a0,OUTFD($fp)
	#lw      a1, BUFFER($fp)
	lw      a1, BUFFER($fp)
	li	a2,1
	li	v0,SYS_write
        syscall
	#jal	ra,t9


read_buffer:
	lw	a0,INTFD($fp)
	#lw      a1, BUFFER($fp)
	lw      a1, BUFFER($fp)
	li	a2,1
	li	v0,SYS_read
        syscall
	#jal	ra,t9

	bgez	v0,while_loop
	nop
exit_while: # Check if we have error
	lw	v1,A_BYTE($fp)
	li	v0,-1
	bne	v1,v0,return_ok
	nop
	li	v0,ERROR_NUMBER_READ_FILE
	b	exit_function
	nop
return_ok:
	lw	v0,EXIT_SUCCESS
exit_function:
	# Stack frame unwinding. Restoring callee-saved reg
	move sp,$fp
	lw  gp,GP(sp)
	lw  $fp,FP(sp)

	# Delete stack frame space and return
	addu  sp,sp,SIZE_SF
	j  ra
  
	.end	unix2dos
	.size	unix2dos, .-unix2dos	

