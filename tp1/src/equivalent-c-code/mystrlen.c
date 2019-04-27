/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP1 - Conjunto de instrucciones MIPS. 
--------------------------------------------------------------
 @Filename: mystrlen.h
--------------------------------------------------------------
 @Authors:
    Battan, Manuel Victoriano.
          mvbattan at gmail dot com
    Gamarra Silva, Cynthia Marlene.
          cyntgamarra at gmail dot com
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com


 @Copyright (C):
    This file is part of 'TP0  - Infraestructura basica.'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
------------------------------------------------------------

Own version of Strlen

----------------------------------------------------------- */
#include "mystrlen.h"

int mystrlen(const char* s)
{
  int i;
  for (i=0; s[i] != 0; i++);
  return i;
}
