# ------------------------------------------------------------
# @Title:   FIUBA - 66.20 Organizacion de Computadoras.
# @Project: TP1 - Conjunto de instrucciones MIPS.
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
#    This file is part of 'TP1 - Conjunto de instrucciones MIPS'.
#    Unauthorized copying or use of this file via any medium
#    is strictly prohibited.
# ------------------------------------------------------------
#
# The Assembly ource files must have .S extension.
# The C source files must have .c extension.
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
_DEPS = common.h messages.h unix2dos.h dos2unix.h mystrlen.h
_SRC = main.c messages.c unix2dos.c dos2unix.c mystrlen.c
_OBJ1 = main_u2d.o messages.o unix2dos.o mystrlen.o
_OBJ2 = main_d2u.o messages.o dos2unix.o mystrlen.o
# ------------------------------------------------------------
# Configuration.
CC = gcc
CFLAGS = -Wall -I. -O0
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
