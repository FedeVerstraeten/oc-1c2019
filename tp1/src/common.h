/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP1 - Conjunto de instrucciones MIPS. 
--------------------------------------------------------------
 @Filename: common.h
--------------------------------------------------------------
 @Authors:
    Battan, Manuel Victoriano.
          mvbattan at gmail dot com
    Gamarra Silva, Cynthia Marlene.
          cyntgamarra at gmail dot com
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com


 @Copyright (C):
    This file is part of 'TP1 - Conjunto de instrucciones MIPS'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
------------------------------------------------------------

Header file for ASM part of codec implementation.

----------------------------------------------------------- */

#include <mips/regdef.h>
#include <sys/syscall.h>
#include <sys/errno.h>

/* ------- Misc. constants ------- */
#define ASCII_NULL 0
#define ASCII_LF 10
#define ASCII_TAB 9
#define ASCII_SPACE 32

#define SIZEOF_UCHAR 1

/* ------- Standard input-output ------- */
#define STDIN_FILENO  0 /* Standard input.  */
#define STDOUT_FILENO 1 /* Standard output.  */
#define STDERR_FILENO 2 /* Standard error output.*/

/* ------- Exit return ------- */
#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
