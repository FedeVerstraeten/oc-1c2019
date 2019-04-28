/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP1 - Conjunto de instrucciones MIPS.
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
    This file is part of 'TP1 - Conjunto de instrucciones MIPS'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
--------------------------------------------------------------

DOS to Unix converter implementation.

----------------------------------------------------------- */
#include <unistd.h>
#include "messages.h"
#include "dos2unix.h"

#define LF 10
#define CR 13
#define OK 0

int dos2unix(int infd, int outfd) {
  unsigned char buffer[2] = {0, 0};
  ssize_t byte_count = 0;

  /* We will use delayed write - we read a new value but we always write the
  oldest one given a 2-bytes buffer, unless CRLF is encountered.
  When CRLF is encountered, we simply write LF and move our buffer one more
  char. */
  byte_count = read(infd, &buffer[0], 1);
  if (byte_count == -1) return ERROR_NUMBER_INPUT_STREAM_READING_MSG;

  while (byte_count > 0) {
    byte_count = read(infd, &buffer[1], 1);
    if (byte_count == -1) return ERROR_NUMBER_INPUT_STREAM_READING_MSG;

    if (byte_count == 0) {
      byte_count = write(outfd, &buffer[0], 1);
      if (byte_count == -1) return ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG;
      return OK;
    }

    if (buffer[0] == CR && buffer[1] == LF) {
      byte_count = write(outfd, &buffer[1], 1);
      if (byte_count == -1) return ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG;

      byte_count = read(infd, &buffer[0], 1);
      if (byte_count == -1) return ERROR_NUMBER_INPUT_STREAM_READING_MSG;

    } else {
      byte_count = write(outfd, &buffer[0], 1);
      if (byte_count == -1) return ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG;

      buffer[0] = buffer[1];
    }
  }

  if (byte_count > 0) byte_count = write(outfd, &buffer[1], 1);
  if (byte_count == -1) return ERROR_NUMBER_OUTPUT_STREAM_WRITING_MSG;
  return byte_count;
}
