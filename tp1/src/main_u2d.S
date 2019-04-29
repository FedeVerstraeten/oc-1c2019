#include "common.h" 

# Argument-building area (ABA).
#define ARG0 0
#define ARG1 4
#define ARG2 8
#define ARG3 12

# Local and Temporary Area (LTA).
#define codecState 16
#define errmsgCodecState 20

# Saved-registers area (SRA).
#define GP 24
#define FP 28
#define RA 32
#define PADDING_1 36

# ABA caller.
#define argc PADDING_1 + 4
#define argv argc + 4

# Calle's Stack frame size 
#define SIZE_SF PADDING_1 + 4

.abicalls
.text
.align  2
.globl  main
.ent  main
main:
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
  sw  ra,RA(sp)
  sw  $fp,FP(sp)
  sw  gp,GP(sp)

# We adopt the convention of using the frame pointer
# as our index in the stack.
  move  $fp,sp

# Now we save the arguments that were loaded by the caller
# in the area reserved by the callee.
  sw  a0,argc($fp)
  sw  a1,argv($fp)

##############################
# body: main_u2d             #
##############################
# Initialize locals.
  li t0,1
  sw t0,codecState($fp)

# Call 'unix2dos' to encode input.
  li  a0,STDIN_FILENO
  li  a1,STDOUT_FILENO
  la  t9,unix2dos
  jal  ra,t9

# Check if unix2dos had errors.
  sw  v0,codecState($fp)
  lw  t0,codecState($fp)
  beq  t0,zero,return_0

# Print error messages
# shift scale ptr size (codecState*=4bytes)
  sll  t0,t0,2
# Block to move through the array.
  la  t1,errmsg
  addu  t0,t0,t1
  lw  a0,0(t0)
# Store errmsg[codecState] in LTA  
  sw  a0,errmsgCodecState($fp)

# Call mystrlen(errmsg[codecState])
  la  t9,mystrlen
  jal  ra,t9

# Load argurments and syscall number  
# write(STDERR_FILENO,errmsg[codecState],mystrlen(errmsg[codecState]));
  move  a2,v0
  lw  a1,errmsgCodecState($fp)  
  li  a0,STDERR_FILENO
  li  v0,SYS_write
  syscall

# return EXIT_FAILURE
return_1:
  li  v0,EXIT_FAILURE
  b  exit_function

# return EXIT_SUCCESS
return_0: 
  li v0,EXIT_SUCCESS

exit_function:
# Stack frame unwinding. Restoring callee-saved reg
  lw  gp,GP(sp)
  lw  $fp,FP(sp)
  lw  ra,RA(sp)

# Delete stack frame space and return
  addu  sp,sp,SIZE_SF
  j  ra
  
.end  main
.size  main, .-main
