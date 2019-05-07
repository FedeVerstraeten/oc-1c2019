#include "common.h"

# Local and Temporary Area (LTA).
#define TEMP_1 0
#define TEMP_0 4

# Saved-registers area (SRA).
#define GP 8
#define FP 12
#define RA 16
#define PADDING_1 20

#define FRAME_SIZE 24
 
.abicalls
.text
.align  2
.globl  dos2unix
.ent  dos2unix
dos2unix:
  .frame  $fp, FRAME_SIZE, ra  
  .set  noreorder
  .cpload t9
  .set  reorder
  subu  sp, sp, FRAME_SIZE
  .cprestore  8
  sw    $fp, FP(sp)
  move  $fp, sp
  sw    ra, PADDING_1($fp)
  
# Begin: read first char
  ori   a0, zero, STDIN_FILENO
  la    a1, TEMP_0($fp)     # &t[0] (old byte)
  ori   a2, zero, 1
  ori   v0, zero, SYS_read
  syscall    # read(stdin, &t[0], 1)

check_read:
  bnez  v0, cont_val
  # File was empty
  ori   v0, zero, EXIT_SUCCESS
  j     end
cont_val:
  addiu   a0, v0, 1
  bnez  a0, read_new
  # End with error: read returned -1
  ori   v0, zero, EXIT_FAILURE
  j     end

# Continue reading using delayed write
read_new:
  ori   a0, zero, STDIN_FILENO
  la    a1, TEMP_1($fp)    # &t[1] (new byte)
  ori   a2, zero, 1
  ori   v0, zero, SYS_read
  syscall       # read(stdin, &t[1], 1)

check_read_2:
  bnez  v0, cont_val_2  # Check if reached EOF
  ori   a0, zero, STDOUT_FILENO
  la    a1, TEMP_0($fp)
  ori   a2, zero, 1
  ori   v0, zero, SYS_write   
  syscall       # We write the oldest byte
  ori   v0, zero, EXIT_SUCCESS
  j     end
cont_val_2:
  addiu   a0, v0, 1     # Check if read returned -1
  bnez  a0, continue
  # Jump with error
  ori   v0, zero, EXIT_FAILURE
  j     end
  
continue:
  lbu   a0, TEMP_0($fp)    # a0 = t[0]
  lbu   a1, TEMP_1($fp)    # a1 = t[1]
  subu  a0, a0, ASCII_CR  
  subu  a1, a1, ASCII_LF
  or    a0, a0, a1
  beqz  a0, write_LF    # if (a0 == CR && a1 == LF) write_LF()

  ori   a0, zero, STDOUT_FILENO
  la    a1, TEMP_0($fp)
  ori   a2, zero, 1
  ori   v0, zero, SYS_write
  syscall       # write(stdout, &t[0], 1)
  lbu   a0, TEMP_1($fp)    # a0 = t[1]
  sw    a0, TEMP_0($fp)    # t[0] = a0
  j     read_new
  
write_LF:
  ori   a0, zero, ASCII_LF    
  sw    a0, TEMP_0($fp)    # t[0] = '\n'
  j     read_new  # We write LF in the next cycle
end:
  lw    ra,  PADDING_1($fp)
  lw    $fp, FP(sp)
  addiu   sp, sp, FRAME_SIZE
  jr    ra
.end dos2unix    
