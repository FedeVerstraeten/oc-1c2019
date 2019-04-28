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
# @Copyright(C):
#     This file is part of
#     'TP1 - Conjunto de instrucciones MIPS'. Unauthorized
#     copying or use of this file via any medium is
#     strictly prohibited.
# ------------------------------------------------------------
#
# ATTENTION:
# This makefile can only be used inside of netBSD for MIPS32
# architecture.
#
# The Assembly source files must have .S extension.
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
_DEPS = common.h messages.h 
_SRC1 = main_u2d.S messages.S unix2dos.S mystrlen.S 
_OBJ1 = main_u2d.o messages.o unix2dos.o mystrlen.o
_SRC2 = main_d2u.S messages.S dos2unix.S mystrlen.S 
_OBJ2 = main_d2u.o messages.o dos2unix.o mystrlen.o

# ------------------------------------------------------------
# Configuration.
CC = gcc
CFLAGS = -Wall -I. -O0 -DNETBSD3
OUTPUT1 = unix2dos
OUTPUT2 = dos2unix

# ------------------------------------------------------------
all: $(OUTPUT1) $(OUTPUT2) 

$(OUTPUT1): $(_SRC1) $(_DEPS)
	$(CC) $(CFLAGS) -o $(OUTPUT1) $(_SRC1)

$(OUTPUT2): $(_SRC2) $(_DEPS)
	$(CC) $(CFLAGS) -o $(OUTPUT2) $(_SRC2)

assembly:
	$(CC) $(CFLAGS) -S $(_SRC1) $(_SRC2) -mrnames

.PHONY: clean assembly

clean:
	rm -f ./*.o *~ core ./*~ ./*.s
	rm -f $(OUTPUT1)
	rm -f $(OUTPUT2)
	
