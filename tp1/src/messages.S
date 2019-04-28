#include "messages.h"

# Error messages indices:
#   1 - ERROR_OUTPUT_STREAM_WRITING_MSG
#   2 - ERROR_INPUT_STREAM_READING_MSG
#   3 - ERROR_READ_FILE_MSG

msg0:
.asciiz ERROR_OUTPUT_STREAM_WRITING_MSG
msg1:
.asciiz ERROR_INPUT_STREAM_READING_MSG
msg2:
.asciiz ERROR_READ_FILE_MSG

.globl  errmsg
.data
errmsg:
.word 0
.word msg0
.word msg1
.word msg2

