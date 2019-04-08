/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: dos2unix.c
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

DOS to Unix converter implementation.

----------------------------------------------------------- */
#include <unistd.h>
#include "dos2unix.h"

#define LF 10
#define CR 13

int dos2unix(int infd, int outfd) {
  unsigned char buffer[2] = {0, 0};
  ssize_t byte_count = 0;

  byte_count = read(infd, &buffer[0], 1);

  while (byte_count > 0) {
    byte_count = read(infd, &buffer[1], 1);
    if (byte_count < 1) {
      byte_count = write(outfd, &buffer[0], 1);
      return 0;
    }

    if (buffer[0] == CR && buffer[1] == LF) {
      byte_count = write(outfd, &buffer[1], 1);
      byte_count = read(infd, &buffer[0], 1);
    } else {
      byte_count = write(outfd, &buffer[0], 1);
      buffer[0] = buffer[1];
    }
  }

  if (byte_count > 0) byte_count = write(outfd, &buffer[1], 1);
  return byte_count;
}
