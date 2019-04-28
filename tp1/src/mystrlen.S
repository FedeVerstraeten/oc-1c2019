#include "common.h"

#  Argument-building area (ABA).
# Function Leaf don't have ABA.

# Local and Temporary Area (LTA).
#define idx 0
#define PADDING 4

# Saved-registers area (SRA).
#define GP 8
#define FP 12

#define SIZE_MYSTRLEN FP + 4

.text
.abicalls
.align  2
.globl  mystrlen
.ent  mystrlen

mystrlen:

  # Debugger metadata.
  .frame  $fp, SIZE_MYSTRLEN, ra

  # Pipeline magic.
  .set  noreorder
  .cpload t9
  .set  reorder

  # Allocate memory for the stack.
  # 2 (SRA) + 2 (LTA)
  subu  sp, sp, SIZE_MYSTRLEN  

  # SRA beginning area.
  .cprestore GP
  
  # Save the callee-saved registers used by 
  # the caller in the SRA.
  sw  $fp, FP(sp)
  sw  gp,GP(sp)

  move  $fp, sp

  # Save 1st arg in ABA caller (always)
  sw  a0, SIZE_MYSTRLEN($fp)

  # for (idx=0; s[idx] != 0; idx++)
  move  t0, zero  # idx=0: t0, fp+0
  sw  t0, idx($fp)  # idx: t0

_for_loop:
  # For condition
  addu  t1, a0, t0  # load address s[idx]: t1
  lb  t1, 0(t1)     # load content s[idx]
  beq t1, zero, _end_for # if s[idx] != 0
  
  # idx++
  lw  t0, idx($fp)
  addu  t0, t0, 1
  sw  t0, idx($fp)
  j _for_loop

_end_for:
  move v0, t0
  lw  gp, GP(sp)
  lw  $fp, FP(sp)
  addu  sp, sp, SIZE_MYSTRLEN
  jr  ra

  .end  mystrlen
  .size mystrlen,.-mystrlen
