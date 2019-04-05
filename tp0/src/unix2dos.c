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
#include "unix2dos.h"
#include <unistd.h>

#define LF 10
#define CR 13

/*outputCode unix2dos(params_t *params);
*/

int unix2dos(int infd, int outfd){
    unsigned char buffer[1] = {0};
    int p = CR;
    ssize_t byte_read = 0;
    byte_read = read(infd, &buffer[0], 1);
    if (byte_read < 1) return byte_read;

    while (byte_read > 0){
	
	if (buffer[0] == LF){
	    byte_read = write(outfd, &p, 1);
            byte_read = write(outfd, &buffer[0], 1);
	}else{
	    byte_read = write(outfd, &buffer[0], 1);
	}
	byte_read = read(infd, &buffer[0], 1);
        if (byte_read < 1) break;
    }
    
    if (byte_read > 0) byte_read = write(outfd, &buffer[1], 1);
    return byte_read;
}
