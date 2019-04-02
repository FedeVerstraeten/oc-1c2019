/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: parser.h
--------------------------------------------------------------
 @Authors:
    Battan, Manuel Victoriano.
          mvbattan at gmail dot com
    Gamarra Silva, Cynthia Marlene.
          cyntgamarra at gmail dot com
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
          
 @Copyright(C):
    This file is part of 'TP0 - Infraestructura basica.'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
--------------------------------------------------------------

Error messages definitions.

----------------------------------------------------------- */
#include "messages.h"

/* Error messages indices:
    1 - ERROR_OUTPUT_STREAM_WRITING_MSG
    2 - ERROR_INPUT_STREAM_READING_MSG
*/

const char *errmsg[] = {0, ERROR_OUTPUT_STREAM_WRITING_MSG,
                        ERROR_INPUT_STREAM_READING_MSG};