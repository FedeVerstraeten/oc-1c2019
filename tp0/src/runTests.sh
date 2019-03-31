#!/bin/bash

# ------------------------------------------------------------
# @Title:   FIUBA - 66.20 Organizacion de Computadoras.
# @Project: TP0 - Infraestructura basica.
# ------------------------------------------------------------
# @Filename: runTests.sh
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
# Script to test errors in the program arguments.
#
# To remove newlines from a textfile, use
# printf %s "$(cat file)" > file
#
# To print contents of a file, including control characters, do:
# oc -c file
#
# ------------------------------------------------------------

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

# ------------------------------------------------------------
# Input parameters tests.
# ------------------------------------------------------------

# Define the expected outputs of each of the test cases with 
# its associated test functions.

function test1_parameter_input_inexistent_stream(){

  EXPECTED_OUTPUT_INEXISTENT_INPUT_STREAM=("ERROR: Can't open input stream.")

  header "TEST1: inexistent 'input' stream."

  commands=(
  "-i 1"
  "-i false_input.txt"
  )

  for i in "${commands[@]}"
  do

    msg_testing "$PROGRAM_NAME $i"

    PROGRAM_OUTPUT=$($PROGRAM_NAME $i 2>&1)

    if [[ "$EXPECTED_OUTPUT_INEXISTENT_INPUT_STREAM" == "$PROGRAM_OUTPUT" ]]; then
      msg_true "$PROGRAM_OUTPUT"
    else
      msg_false "$PROGRAM_OUTPUT"
      failedTests=$(($failedTests+1));
    fi

  done
}

function test12_parameter_input_invalid_stream(){

  EXPECTED_OUTPUT_INPUT_INVALID_STREAM=("ERROR: Invalid input stream.")

  header "TEST12: invalid 'input' stream."

  commands=(
  "-i ."
  "-i .."
  "-i /"
  "-i //"
  )

  for i in "${commands[@]}"
  do

    msg_testing "$PROGRAM_NAME $i"

    PROGRAM_OUTPUT=$($PROGRAM_NAME $i 2>&1)

    if [[ "$EXPECTED_OUTPUT_INPUT_INVALID_STREAM" == "$PROGRAM_OUTPUT" ]]; then
      msg_true "$PROGRAM_OUTPUT"
    else
      msg_false "$PROGRAM_OUTPUT"
      failedTests=$(($failedTests+1));
    fi

  done
}

function test2_parameter_output_stream(){

  EXPECTED_OUTPUT_INVALID_OUTPUT_STREAM=("ERROR: Invalid output stream.")

  INPUT_FILE=$(echo $PROGRAM_NAME | sed -r 's/..(.*)2.*/\1/g')

  header "TEST2: invalid 'output' stream."

  commands=(
  "-i ../test/loremipsum_${INPUT_FILE}.txt -o ."
  "-i ../test/loremipsum_${INPUT_FILE}.txt -o .."
  "-i ../test/loremipsum_${INPUT_FILE}.txt -o /"
  "-i ../test/loremipsum_${INPUT_FILE}.txt -o //"
  )

  for i in "${commands[@]}"
  do

    msg_testing "$PROGRAM_NAME $i"

    PROGRAM_OUTPUT=$($PROGRAM_NAME $i 2>&1)

    if [[ "$EXPECTED_OUTPUT_INVALID_OUTPUT_STREAM" == "$PROGRAM_OUTPUT" ]]; then
      msg_true "$PROGRAM_OUTPUT"
    else
      msg_false "$PROGRAM_OUTPUT"
      failedTests=$(($failedTests+1));
    fi

  done
}


function test4_valid_parameters(){

  EXPECTED_OUTPUT_VALID_PARAMETERS=()

  INPUT_FILE=$(echo $PROGRAM_NAME | sed -r 's/..(.*)2.*/\1/g')

  header "TEST4: all options with correct parameters."

  commands=(
  "-i ../test/loremipsum_${INPUT_FILE}.txt -o ../test/out_${INPUT_FILE}_1.txt"
  "-i ../test/out_${INPUT_FILE}_1.txt -o ../test/out_${INPUT_FILE}_2.txt")

  for i in "${commands[@]}"
  do

    msg_testing "$PROGRAM_NAME $i"

    PROGRAM_OUTPUT=$($PROGRAM_NAME $i 2>&1)


    if [[ "$EXPECTED_OUTPUT_VALID_PARAMETERS" == "$PROGRAM_OUTPUT" ]]; then
      msg_true "$PROGRAM_OUTPUT"
    else
      msg_false "$PROGRAM_OUTPUT"
      failedTests=$(($failedTests+1));
    fi

  done
}

# ------------------------------------------------------------
# Input-output validation tests.
# ------------------------------------------------------------
function IO_validation_passed(){
  echo -e "$GREEN\0PASSED: $DEFAULT $1"
}
function IO_validation_failed(){
  echo -e "$RED\0FAILED $DEFAULT $1"
}

TESTS_DIR="../test_IO";
mkdir $TESTS_DIR;

function test5_IO_validation(){
  header "TEST5: input-output should be the same."

  # Running 'n*5' attempts for the input size 'n'
  n=1024;
  nLimit=$((1024*5));

  while [ $n -le $nLimit ]
  do
    head -c $n </dev/urandom >$TESTS_DIR/in.bin;
    $PROGRAM_NAME -a encode -i $TESTS_DIR/in.bin -o $TESTS_DIR/out.b64;
    $PROGRAM_NAME -a decode -i $TESTS_DIR/out.b64 -o $TESTS_DIR/out.bin;

    diff_result="$(diff -q $TESTS_DIR/in.bin $TESTS_DIR/out.bin)";

    if [[ -z ${diff_result} ]]; then :;
      IO_validation_passed "n = $n";
    else
      IO_validation_failed "n = $n";
      error_msg "in.bin";
      cat $TESTS_DIR/in.bin | od -A x -t x1z -v;
      error_msg "out.b64";
      cat $TESTS_DIR/out.b64 | od -A x -t x1z -v;
      error_msg "out.bin";
      cat $TESTS_DIR/out.bin | od -A x -t x1z -v;
      failedTests=$(($failedTests+1));
      break;
    fi

    n=$(($n*2));

    rm -f $TESTS_DIR/in.bin $TESTS_DIR/out.b64 $TESTS_DIR/out.bin
  done
}

function test51_IO_validation(){
  header "TEST51: input known text with known encoding."

  $PROGRAM_NAME -a encode -i $TESTS_DIR/leviathan.input -o $TESTS_DIR/leviathan_out.b64;

  diff_result="$(diff $TESTS_DIR/leviathan_out.b64 ../test/dos.txt)";

  if [[ -z ${diff_result} ]]; then :;
    IO_validation_passed "No differences.";
  else
    IO_validation_failed "Differences: \n${diff_result}";
    failedTests=$(($failedTests+1));
  fi
}

function test52_IO_validation(){
  header "TEST52: Encode array (Uno, Dos, Tres) with ${PROGRAM_NAME} and verify the correct output."

  INPUT_FILE=$(echo $PROGRAM_NAME | sed -r 's/..(.*)2.(.*)/\2/g')

  (echo "Uno"; echo "Dos"; echo "Tres") | $PROGRAM_NAME > $TESTS_DIR/out_test52.txt
  diff_result="$(diff $TESTS_DIR/out_test52.txt $TESTS_DIR/$INPUT_FILE.txt)";

  if [[ -z ${diff_result} ]]; then :;
    IO_validation_passed "No differences.";
  else
    IO_validation_failed "Differences: \n${diff_result}";
    failedTests=$(($failedTests+1));
  fi
}

function test56_IO_validation(){
  header "TEST56: Check bit by bit."

  program_output="$(echo -n xyz | $PROGRAM_NAME | $PROGRAM_NAME -a decode | od -t c)";
  correct_output="0000000    x   y   z 0000003";
  diff_result="$(diff  <(echo $program_output ) <(echo $correct_output))";

  if [[ -z ${diff_result} ]]; then :;
    IO_validation_passed "No differences.";
  else
    IO_validation_failed "Differences: \n${diff_result}";
    failedTests=$(($failedTests+1));
  fi
}

function test57_IO_validation(){
  header "TEST57: Check max line length and number of encoded bytes."

  program_output_line_count="$(echo -n "$(yes | head -c 1024 | $PROGRAM_NAME -a encode)" | wc -l)";

  # 1024 bytes[base256] => (8190+2) bits => 1365 bytes[base64] + 2 bits
  # 1365 bytes[base64] + 2 bits + '==' =>  1366 bytes[base64]
  # floor(1366 bytes[base64] / 76 charEachLine) => 17 lines
  correct_output_line_count="      17";
  diff_result_line_count="$(diff  <(echo "$program_output_line_count" ) <(echo "$correct_output_line_count"))";

  if [[ -z ${diff_result_line_count} ]]; then :;
    IO_validation_passed "No differences in line count.";
  else
    IO_validation_failed "Differences in line count:
    Program output:${program_output_line_count}
    Correct output:${correct_output_line_count}";
    failedTests=$(($failedTests+1));
  fi

  program_output_word_count="$(yes | head -c 1024 | $PROGRAM_NAME -a encode | $PROGRAM_NAME -a decode | wc -c)";
  correct_output_word_count="    1024";
  diff_result_word_count="$(diff  <(echo "$program_output_word_count" ) <(echo "$correct_output_word_count"))";

  if [[ -z ${diff_result_word_count} ]]; then :;
    IO_validation_passed "No differences in word count.";
  else
    IO_validation_failed "Differences in word count:
    Program output:${program_output_word_count}
    Correct output:${correct_output_word_count}";
    failedTests=$(($failedTests+1));
  fi
}

# ------------------------------------------------------------
# Encoding-Decoding execution times tests.
# ------------------------------------------------------------
function test6_encoding_execution_times(){
  header "TEST6: encoding execution times."

  n=1;
  nLimit=$((1024*10000));
  rm -f $TESTS_DIR/encodingTimes.txt

  while [ $n -le $nLimit ]
  do
    head -c $n </dev/urandom >$TESTS_DIR/in.bin;
    ts=$(date +%s%N);
    $PROGRAM_NAME -a encode -i $TESTS_DIR/in.bin -o $TESTS_DIR/out.b64;
    tt=$((($(date +%s%N) - $ts)/1000000));

    printf 'n: %-10d %10s %.2f [ms]\n' "$n" " " "$tt"
    printf '%-10d %.2f\n' "$n" "$tt" >> $TESTS_DIR/encodingTimes.txt

    n=$((n*2));

    rm -f $TESTS_DIR/in.bin $TESTS_DIR/out.b64 $TESTS_DIR/out.bin
  done
}

function test7_decoding_execution_times(){
  header "TEST7: decoding execution times."

  n=1;
  nLimit=$((1024*10000));
  rm -f $TESTS_DIR/decodingTimes.txt

  while [ $n -le $nLimit ]
  do
    head -c $n </dev/urandom >$TESTS_DIR/in.bin;
    $PROGRAM_NAME -a encode -i $TESTS_DIR/in.bin -o $TESTS_DIR/out.b64;
    ts=$(date +%s%N);
    $PROGRAM_NAME -a decode -i $TESTS_DIR/out.b64 -o $TESTS_DIR/out.bin;
    tt=$((($(date +%s%N) - $ts)/1000000));

    printf 'n: %-10d %10s %.2f [ms]\n' "$n" " " "$tt"
    printf '%-10d %.2f\n' "$n" "$tt" >> $TESTS_DIR/decodingTimes.txt

    n=$((n*2));

    rm -f $TESTS_DIR/in.bin $TESTS_DIR/out.b64 $TESTS_DIR/out.bin
  done
}

# ------------------------------------------------------------
# Run the tests. Program unix2dos
# ------------------------------------------------------------

# Program name to test.
PROGRAM_NAME='./unix2dos'

test1_parameter_input_inexistent_stream
test12_parameter_input_invalid_stream

test2_parameter_output_stream

test4_valid_parameters

# test51_IO_validation
test52_IO_validation

# ------------------------------------------------------------
# Run the tests. Program dos2unix
# ------------------------------------------------------------
# Program name to test.
PROGRAM_NAME='./dos2unix'

test1_parameter_input_inexistent_stream
test12_parameter_input_invalid_stream

test2_parameter_output_stream

test4_valid_parameters


# ------------------------------------------------------------
# Run encoding-decoding tests.
# ------------------------------------------------------------
# test5_IO_validation
# test56_IO_validation
# test57_IO_validation
# test6_encoding_execution_times
# test7_decoding_execution_times

header "Test suite ended."

if [[ $failedTests -eq $zero ]]; then
  success_msg "All tests passed.";
else
  error_msg "Failed tests: $failedTests";
fi
