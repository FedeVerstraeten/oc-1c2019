/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP1 - Conjunto de instrucciones MIPS
--------------------------------------------------------------
 @Filename: unix2dos.h
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

Unis to DOS converter definitions and declarations.

----------------------------------------------------------- */
#ifndef UNIX2DOS2__H
#define UNIX2DOS2__H

#include <stdio.h>
#include "messages.h"
#include <unistd.h>

#define LF 10
#define CR 13
#define READ_OK 0

int unix2dos(int infd, int outfd);

#endif
