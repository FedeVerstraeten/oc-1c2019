#include "common.h"
#include "messages.h"  

# Local and Temporary Area (LTA).
#define BUFFER 0
#define CONTROL_CHAR 1
#define PADDING_0 2 
#define A_BYTE 4


# Saved-registers area (SRA).
#define GP 8
#define FP 12

# ABA caller.
#define INTFD 16
#define OUTFD 20

#define SIZE_SF FP + 4

.abicalls
.text
.align  2
.globl  unix2dos
.ent  unix2dos

unix2dos:
  # Debugger metadata.
  .frame  $fp,SIZE_SF,ra

  # Pipeline magic.
  .set  noreorder
  .cpload  t9
  .set  reorder
  
  # Allocate memory for the stack. 
  subu  sp,sp,SIZE_SF
  
  # SRA beginning area.
  .cprestore GP

  # Save the callee-saved registers used by the caller in the SRA.
  sw  $fp,FP(sp)
  sw  gp,GP(sp)
  # We must set the $fp to the beginning of the stack.
  move $fp,sp

  # Now we save the arguments that were loaded by the caller
  # in the area reserved by the caller.
  sw  a0,INTFD($fp)
  sw  a1,OUTFD($fp)

  # Set local variables
  sb 	zero,BUFFER($fp)
  li  t0,ASCII_CR
  sb  t0,CONTROL_CHAR($fp)
  sw  zero,A_BYTE($fp)
  
  # Read one character using syscall read
  lw  a0,INTFD($fp)
  addu a1,$fp,BUFFER
  li  a2,1
  li  v0,SYS_read
  syscall

  # If a_byte > 0
  sw  v0,A_BYTE($fp)
  bgtz  v0,while_loop
  nop
  li  v0,ERROR_NUMBER_READ_FILE
  b  exit_function

while_loop:
	# While pre-condition a_byte > 0
  lw  t0,A_BYTE($fp)
  bgtz  t0,equal_LF
  nop
  b  exit_while

equal_LF:
	#If buffer equal to LF
  lbu  t1,BUFFER($fp)
  li  t0,ASCII_LF
  bne  t1,t0,else_buffer
  
  # write(outfd, &control_character, 1);
  lw  a0,OUTFD($fp) # outfd
  addu a1,$fp,CONTROL_CHAR # &control_character
  li  a2,1
  li  v0,SYS_write
  syscall

  # Store return value of syscall
  sw  v0,A_BYTE($fp)
 
  # write(outfd, &buffer[0], 1);
  lw  a0,OUTFD($fp) # outfd
  addu a1,$fp,BUFFER # &(*(buffer+0))
  li  a2,1
  li  v0,SYS_write
  syscall

  # Store return value of syscall
  sw  v0,A_BYTE($fp)
  b  	read_buffer

else_buffer: 
	# If not equal to LF
  # write(outfd, &buffer[0], 1);
  lw  a0,OUTFD($fp) # outfd
  addu a1,$fp,BUFFER # &(*(buffer+0))
  li  a2,1
  li  v0,SYS_write
  syscall
  
 	# Store return value of syscall
  sw  v0,A_BYTE($fp)

read_buffer:
	# read(infd, &buffer[0], 1);
  lw  a0,INTFD($fp) # infd
  addu a1,$fp,BUFFER # &(*(buffer+0))
  li  a2,1
  li  v0,SYS_read
  syscall

	# Store return value of syscall
  sw  v0,A_BYTE($fp)

 	# If a_byte > 0
  bgtz  v0,while_loop
 
exit_while: # Check if we have error
  lw  t1,A_BYTE($fp)
  li  t0,-1
  bne  t1,t0,return_ok
  li  v0,ERROR_NUMBER_READ_FILE
  b  exit_function
  
return_ok:
  li  v0,EXIT_SUCCESS

exit_function:
  # Stack frame unwinding. Restoring callee-saved reg
  lw  gp,GP(sp)
  lw  $fp,FP(sp)

  # Delete stack frame space and return
  addu  sp,sp,SIZE_SF
  j  ra
  
.end  unix2dos
.size  unix2dos, .-unix2dos  
