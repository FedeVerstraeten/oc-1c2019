/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
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
    This file is part of 'TP0 - Infraestructura basica.'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
------------------------------------------------------------

Program's common messages.

----------------------------------------------------------- */
#ifndef MESSAGES__H
#define MESSAGES__H

#ifndef ERROR_INVALID_INPUT_STREAM
#define ERROR_INVALID_INPUT_STREAM "ERROR: Invalid input stream.\n"
#endif
#ifndef ERROR_OPENING_INPUT_STREAM
#define ERROR_OPENING_INPUT_STREAM "ERROR: Can't open input stream.\n"
#endif
#ifndef ERROR_INVALID_OUTPUT_STREAM
#define ERROR_INVALID_OUTPUT_STREAM "ERROR: Invalid output stream.\n"
#endif
#ifndef ERROR_OPENING_OUTPUT_STREAM
#define ERROR_OPENING_OUTPUT_STREAM "ERROR: Can't open output stream.\n"
#endif
#ifndef ERROR_ACTION_INVALID_ARGUMENT
#define ERROR_ACTION_INVALID_ARGUMENT "ERROR: Invalid action argument.\n"
#endif
#ifndef ERROR_OUTPUT_STREAM_WRITING_MSG
#define ERROR_OUTPUT_STREAM_WRITING_MSG "Output error when writing stream.\n"
#endif
#ifndef ERROR_INPUT_STREAM_READING_MSG
#define ERROR_INPUT_STREAM_READING_MSG "Input error when reading stream.\n"
#endif

/* These values must correspond with 'errmsg' array. */
#ifndef ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG
#define ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG 1
#endif

#ifndef ERROR_NUMBER_INPUT_STREAM_READING_MSG
#define ERROR_NUMBER_INPUT_STREAM_READING_MSG 2
#endif

#ifndef ERROR_READ_FILE
#define ERROR_READ_FILE 3
#endif

/* Error messages indices:
    1 - ERROR_OUTPUT_STREAM_WRITING_MSG
    2 - ERROR_INPUT_STREAM_READING_MSG
    3 - ERROR_READ_FILE
*/
extern const char *errmsg[];

#endif
