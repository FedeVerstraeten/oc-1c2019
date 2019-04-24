# ------------------------------------------------------------
# @Title:   FIUBA - 66.20 Organizacion de Computadoras.
# @Project: TP0 - Infraestructura basica.
# ------------------------------------------------------------
# @Filename: makefile
# ------------------------------------------------------------
# @Authors:
#    Battan, Manuel Victoriano.
#          mvbattan at gmail dot com
#    Gamarra Silva, Cynthia Marlene.
#          cyntgamarra at gmail dot com
#    Verstraeten, Federico.
#          federico.verstraeten at gmail dot com
#
# @Copyright (C):
#    This file is part of 'TP0 - Infraestructura basica.'.
#    Unauthorized copying or use of this file via any medium
#    is strictly prohibited.
# ------------------------------------------------------------
#
# The source files must have .c extension.
# The object code must have .o extension.
# The header files must have .h extension.
#
# To compile, execute 'make'.
# To clean all the compilation files, issue the command
# 'make clean'.
#
# ------------------------------------------------------------
# List all the header and object files separated by a blank
# space.
_DEPS = common.h messages.h parser.h unix2dos.h dos2unix.h
_SRC = main.c messages.c parser.c unix2dos.c dos2unix.c
_OBJ1 = main_u2d.o messages.o parser.o unix2dos.o
_OBJ2 = main_d2u.o messages.o parser.o dos2unix.o
# ------------------------------------------------------------
# Configuration.
CC = gcc
CFLAGS = -ansi -Wall -I. -O0
OUTPUT1 = unix2dos
OUTPUT2 = dos2unix

#Pre compiler options
_PCOPT1 = -DUNIX2DOS_ENC
_PCOPT2 = -DDOS2UNIX_ENC
# ------------------------------------------------------------
all: $(OUTPUT1) $(OUTPUT2)

main_u2d.o: main.c
	$(CC) $(CFLAGS) $(_PCOPT1) -c main.c -o main_u2d.o

main_d2u.o: main.c
	$(CC) $(CFLAGS) $(_PCOPT2) -c main.c -o main_d2u.o

$(OUTPUT1): $(_OBJ1)
	$(CC) $(CFLAGS) -o $(OUTPUT1) $(_OBJ1) 

$(OUTPUT2): $(_OBJ2)
	$(CC) $(CFLAGS) -o $(OUTPUT2) $(_OBJ2) 

assembly:
	$(CC) $(CFLAGS) -S $(_SRC) $(ARGS)

.PHONY: clean assembly

clean:
	rm -f ./*.o *~ core ./*~ ./*.s
	rm -f $(OUTPUT1)
	rm -f $(OUTPUT2)
