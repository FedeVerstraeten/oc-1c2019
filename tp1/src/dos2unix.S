#include "common.h"

#define FRAME_SIZE 16
#define CR 13
#define LF 10
 
.abicalls
.text
.align	2
.globl	dos2unix
.ent	dos2unix
dos2unix:
	.frame        $fp, FRAME_SIZE, ra	
	.set          noreorder
	.cpload	      t9
	.set          reorder
	subu          sp, sp, FRAME_SIZE
	.cprestore    8
	sw            $fp, 12(sp)
    move          $fp, sp
    or            a0, zero, zero
    la            a1, 4($fp)
    ori           a2, zero, 1
    ori           v0, zero, SYS_read
    syscall       # read(stdin, &t1, 1)

check_read:
    bnez          v0, cont_val
    j             end
cont_val:
    addiu         a0, v0, 1
    bnez          a0, read_new
    # Jump with error
    j             end
read_new:
    ori           a0, zero, 0
    la            a1, 0($fp)
    ori           a2, zero, 1
    ori           v0, zero, SYS_read
    syscall       # read(stdin, &t2, 1)

check_read_2:
    bnez          v0, cont_val_2
    ori           a0, zero, 1
    la            a1, 4($fp)
    ori           a2, zero, 1
    ori           v0, zero, SYS_write
    syscall
    j             end
cont_val_2:
    addiu         a0, v0, 1
    bnez          a0, continue
    # Jump with error
    j             end
continue:
    lbu           a0, 4($fp)
    lbu           a1, 0($fp)
    subu          a0, a0, CR
    subu          a1, a1, LF
    or            a0, a0, a1
    beqz          a0, write_LF

    ori           a0, zero, 1
    la            a1, 4($fp)
    ori           a2, zero, 1
    ori           v0, zero, SYS_write
    syscall       # write(stdout, &t1, 1)
    lbu           a0, 0($fp)
    sw            a0, 4($fp)
    j             read_new
write_LF:
    ori           a0, zero, 10
    sw            a0, 4($fp)
    j             read_new
end:
    lw            $fp, 12(sp)
    addiu         sp, sp, FRAME_SIZE
    ori           a0, zero, 0
    ori           v0, zero, SYS_exit
    syscall
.end dos2unix    
    
