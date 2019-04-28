#!/bin/bash

# ------------------------------------------------------------
# @Title:   FIUBA - 66.20 Organizacion de Computadoras.
# @Project: TP1 - Conjunto de instrucciones MIPS.
# ------------------------------------------------------------
# @Filename: execTimesTest.sh
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
# Script to test errors in the program arguments.
#
# To remove newlines from a textfile, use
# printf %s "$(cat file)" > file
#
# To print contents of a file, including control characters, do:
# oc -c file
#
# ------------------------------------------------------------
#
# Script to test execution times.
# Comparison between the developed code and a Perl script.
#
# ------------------------------------------------------------

# Test directory
TEST_DIR="../test";

# Failed tests counter.
failedTests=0;

# Colors to be used.
RED="\e[31m";
GREEN="\e[32m";
CYAN="\e[96m";
YELLOW="\e[93m";
BOLD="\033[1m";
DEFAULT="\e[0m";

# Helper and formatting functions definitions.
function header() {
  echo -e "$CYAN------------------------------------------------------$DEFAULT";
  echo -e "$CYAN$1$DEFAULT";
  echo -e "$CYAN------------------------------------------------------$DEFAULT";
}

function msg_true() {
  echo -e "$GREEN\0PASSED \n $DEFAULT PROGRAM OUTPUT:\n\t$1";
}

function msg_false() {
  echo -e "$RED\0FAILED \n $DEFAULT PROGRAM OUTPUT:\n\t$1";
}

function msg_testing() {
  echo -e "Testing: $BOLD$1$DEFAULT";
}

function success_msg() {
  echo -e "  $GREEN$1$DEFAULT";
}

function error_msg() {
  echo -e "  $RED$1$DEFAULT";
}

NLIMIT=$((1024*10000));


function random_files_generation(){

  echo -n "Generating random files.."
  n=1
  while [ $n -le $NLIMIT ]
  do
    head -c $n </dev/urandom >$TEST_DIR/in.$n.u;
    echo -n "."
    n=$((n*2));
  done
  echo "  Ready!"
}
# ------------------------------------------------------------
# Encoding-Decoding execution times tests.
# ------------------------------------------------------------


function test1_encoding_comparison_execution_times(){
  header "TEST1: unix2dos runtime comparison Perl vs Developed code."
  header "#Test                Perl              Developed code"
  n=1;
  rm -f $TEST_DIR/encodingComp.txt

  while [ $n -le $NLIMIT ]
  do
    # Encoding unix2dos using Perl
    ts=$(date +%s);
    perl -pi -e 's/\n/\r\n/' -X <$TEST_DIR/in.$n.u >$TEST_DIR/out.$n.d;
    tt_std=$((($(date +%s) - $ts)/1000000));

    # Encoding using development
    ts=$(date +%s);
    $PROGRAM_ENC < $TEST_DIR/in.$n.u > $TEST_DIR/out.$n.d;
    tt_dev=$((($(date +%s) - $ts)/1000000));    

    printf 'n: %-8d %8s %.2f [ms] %8s %.2f [ms]\n' "$n" " " "$tt_std" " " "$tt_dev" 
    printf '%-8d %-8.2f %.2f\n' "$n" "$tt_std" "$tt_dev">> $TEST_DIR/encodingComp.txt
  
    n=$((n*2));

  done
}

function test1_decoding_comparison_execution_times(){
  header "TEST2: dos2unix runtime comparison Perl vs Developed code."
  header "#Test                Perl              Developed code"


  n=1;
  rm -f $TEST_DIR/decodingComp.txt

  while [ $n -le $NLIMIT ]
  do
   # Decoding dos2unix using Perl
    ts=$(date +%s);
    perl -pi -e 's/\r\n/\n/' -X <$TEST_DIR/in.$n.u >$TEST_DIR/out.$n.d;
    tt_std=$((($(date +%s) - $ts)/1000000));

    ts=$(date +%s);
    $PROGRAM_DEC < $TEST_DIR/out.$n.d > $TEST_DIR/out.$n.u;
    tt_dev=$((($(date +%s) - $ts)/1000000));

    printf 'n: %-8d %8s %.2f [ms] %8s %.2f [ms]\n' "$n" " " "$tt_std" " " "$tt_dev" 
    printf '%-8d %-8.2f %.2f\n' "$n" "$tt_std" "$tt_dev">> $TEST_DIR/decodingComp.txt

    n=$((n*2));

  done
}

# ------------------------------------------------------------
# Run encoding-decoding tests.
# ------------------------------------------------------------
PROGRAM_ENC='./unix2dos'
PROGRAM_DEC='./dos2unix'

random_files_generation
test1_encoding_comparison_execution_times
test1_decoding_comparison_execution_times

# Delete random files
rm -f $TEST_DIR/in.*.u $TEST_DIR/out.*.d $TEST_DIR/out.*.u

header "Test suite ended."

if [[ $failedTests -eq $zero ]]; then
  success_msg "All tests passed.";
else
  error_msg "Failed tests: $failedTests";
fi
