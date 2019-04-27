/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: main.c
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

Main program. Entry point.

----------------------------------------------------------- */

/*Necessary to avoid the warning: implicit declaration 
of function fileno. This must be at the beginning.*/
#define _POSIX_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "common.h"
#include "unix2dos.h"
#include "dos2unix.h"

size_t mystrlen(const char* s);

int main(int argc, char **argv)
{

  int codecState=1;

#ifdef UNIX2DOS_ENC
  codecState = unix2dos(STDIN_FILENO, STDOUT_FILENO);
#endif
 
#ifdef DOS2UNIX_ENC
  codecState = dos2unix(STDIN_FILENO, STDOUT_FILENO);
#endif

  if (codecState != 0) {
    write(STDERR_FILENO, errmsg[codecState], mystrlen(errmsg[codecState]));
    return EXIT_FAILURE;
  }
  
  return EXIT_SUCCESS;
}
