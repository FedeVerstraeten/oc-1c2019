/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: dos2unix.h
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

DOS to Unix converter  definitions and declarations.

----------------------------------------------------------- */
#ifndef DOS2UNIX__H
#define DOS2UNIX__H

#include <stdio.h>
#include "common.h"
#include "messages.h"

//#define ANY_CONSTANT 10

outputCode dos2unix(params_t *params);

#endif
