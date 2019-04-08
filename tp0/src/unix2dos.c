/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: unix2dos.c
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

Unix to DOS converter implementation.

----------------------------------------------------------- */
#include <unistd.h>
#include "unix2dos.h"

int unix2dos(int infd, int outfd) {
  unsigned char buffer[1] = {0};
  unsigned char control_character = CR;
  ssize_t a_byte = 0;

  a_byte = read(infd, &buffer[0], 1);
  if (a_byte < 1) return ERROR_NUMBER_READ_FILE;

  while (a_byte > 0) {
    if (buffer[0] == LF) {
      a_byte = write(outfd, &control_character, 1);
      a_byte = write(outfd, &buffer[0], 1);
    } else {
      a_byte = write(outfd, &buffer[0], 1);
    }
    a_byte = read(infd, &buffer[0], 1);
    if (a_byte < 1) break;
  }

  if (a_byte == -1) return ERROR_NUMBER_READ_FILE;
  return READ_OK;
}
