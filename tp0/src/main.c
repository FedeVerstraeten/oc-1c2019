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
  params_t params;

  /* We parse the command line and check for errors. */
  outputCode cmdParsingState = parseCmdline(argc, argv, &params);

  if (cmdParsingState == outERROR)
  {
    exit(EXIT_FAILURE);
  }

  /* Open the files descriptor */
  int codecState=1;
  int infd = fileno(params.inputStream);
  int outfd = fileno(params.outputStream);


#ifdef UNIX2DOS_ENC
  codecState = unix2dos(infd, outfd);
#endif

#ifdef DOS2UNIX_ENC
  codecState = dos2unix(infd, outfd);
#endif

  if (codecState != 0) {
    fprintf(stderr, "%s", errmsg[codecState]);
    exit(EXIT_FAILURE);
  }
  
  /* Close and free what is left. */
  fclose(params.inputStream);
  fclose(params.outputStream);

  return EXIT_SUCCESS;
}
