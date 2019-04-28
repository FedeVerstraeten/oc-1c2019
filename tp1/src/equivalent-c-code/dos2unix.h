/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP1 - Conjunto de instrucciones MIPS.
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
    This file is part of 'TP1 - Conjunto de instrucciones MIPS'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
--------------------------------------------------------------

DOS to Unix converter definitions and declarations.

----------------------------------------------------------- */
#ifndef DOS2UNIX__H
#define DOS2UNIX__H

#include <stdio.h>
#include "messages.h"

int dos2unix(int infd, int outfd);

#endif
