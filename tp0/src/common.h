/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: common.h
--------------------------------------------------------------
 @Authors:
    Battan, Manuel.
          mvbattan at gmail dot com
    Gamarra, Cynthia.
          cyntgamarra at gmail dot com
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com


 @Copyright (C):
    This file is part of 'TP0 - Infraestructura basica.'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
------------------------------------------------------------

Common program structures.

----------------------------------------------------------- */
#ifndef COMMON__H
#define COMMON__H

#ifndef VERSION
#define VERSION "1.0.0"
#endif

typedef struct params_t
{
  char *action;
  FILE *inputStream;
  FILE *outputStream;
} params_t;

typedef enum outputCodes_ { outOK, outERROR } outputCode;

#endif
