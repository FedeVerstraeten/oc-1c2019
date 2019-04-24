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
    This file is part of 'TP0 - Infraestructura basica.'.
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
#include <string.h>
#include <unistd.h>
#include "common.h"
#include "unix2dos.h"
#include "dos2unix.h"
#include "parser.h"

int main(int argc, char **argv)
{

  /* Open the files descriptor */
  int codecState=1;
  /* int infd = fileno(stdin);
  int outfd = fileno(stdout); */

  /* File Descriptor defined into /usr/include/unistd.h
     is not neccesary open and close them. 
    STDIN_FILENO  0 -- Standard input.
    STDOUT_FILENO 1 -- Standard output.
    STDERR_FILENO 2 -- Standard error output.
  */

#ifdef UNIX2DOS_ENC
  codecState = unix2dos(STDIN_FILENO, STDOUT_FILENO);
#endif

#ifdef DOS2UNIX_ENC
  codecState = dos2unix(STDIN_FILENO, STDOUT_FILENO);
#endif

  if (codecState != 0) {
    /* TODO we should use write function instead of fprintf*/
    fprintf(stderr, "%s", errmsg[codecState]);
    exit(EXIT_FAILURE);
  }
  
  return EXIT_SUCCESS;
}
