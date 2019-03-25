/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: parser.h
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

CLA parser definitions and declarations.

----------------------------------------------------------- */
#ifndef PARSER__H
#define PARSER__H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "common.h"
#include "messages.h"

#ifndef STD_STREAM_TOKEN
#define STD_STREAM_TOKEN "-"
#endif

/* Actions definitions */
#ifndef ENCODE_STR_TOKEN
#define ENCODE_STR_TOKEN "encode"
#endif
#ifndef DECODE_STR_TOKEN
#define DECODE_STR_TOKEN "decode"
#endif

extern struct option cmdOptions[];

outputCode parseCmdline(int argc, char **argv, params_t *params);
outputCode optAction(char *arg, params_t *params);
outputCode optOutput(char *arg, params_t *params);
outputCode optInput(char *arg, params_t *params);
void optHelp(char *arg);
void optVersion(void);

#endif
