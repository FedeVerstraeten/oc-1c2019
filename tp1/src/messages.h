/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP1 - Conjunto de instrucciones MIPS. 
--------------------------------------------------------------
 @Filename: messages.h
--------------------------------------------------------------
 @Authors:
    Battan, Manuel Victoriano.
          mvbattan at gmail dot com
    Gamarra Silva, Cynthia Marlene.
          cyntgamarra at gmail dot com
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com


 @Copyright (C):
    This file is part of 'TP1 - Conjunto de instrucciones MIPS'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
------------------------------------------------------------

Program's common messages.

----------------------------------------------------------- */
#ifndef MESSAGES__H
#define MESSAGES__H

/* ------- Messages definitions ------- */

#ifndef ERROR_OUTPUT_STREAM_WRITING_MSG
#define ERROR_OUTPUT_STREAM_WRITING_MSG "ERROR: Output error when writing stream.\n"
#endif
#ifndef ERROR_INPUT_STREAM_READING_MSG
#define ERROR_INPUT_STREAM_READING_MSG "ERROR: Input error when reading stream.\n"
#endif
#ifndef ERROR_READ_FILE_MSG
#define ERROR_READ_FILE_MSG "ERROR: Program unix2dos can not read file.\n"
#endif

/* These values must correspond with index 'errmsg' array. */

/* Error messages indices:
    1 - ERROR_OUTPUT_STREAM_WRITING_MSG
    2 - ERROR_INPUT_STREAM_READING_MSG
    3 - ERROR_READ_FILE_MSG
*/

#ifndef ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG
#define ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG 1
#endif

#ifndef ERROR_NUMBER_INPUT_STREAM_READING_MSG
#define ERROR_NUMBER_INPUT_STREAM_READING_MSG 2
#endif

#ifndef ERROR_READ_FILE
#define ERROR_NUMBER_READ_FILE 3
#endif

#endif
