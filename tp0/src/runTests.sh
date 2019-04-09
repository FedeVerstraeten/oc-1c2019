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

  INPUT_FILE=$(echo $PROGRAM_NAME | perl -pi -e 's/..(.*)2.*/\1/g' -X)

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


function test3_valid_parameters(){

  EXPECTED_OUTPUT_VALID_PARAMETERS=()

  INPUT_FILE=$(echo $PROGRAM_NAME | perl -pi -e 's/..(.*)2.*/\1/g' -X)

  header "TEST3: all options with correct parameters."

  commands=(
  "-i $TEST_DIR/loremipsum_${INPUT_FILE}.txt -o $TEST_DIR/out_test3_${INPUT_FILE}_1.txt"
  "-i $TEST_DIR/out_test3_${INPUT_FILE}_1.txt -o $TEST_DIR/out_test3_${INPUT_FILE}_2.txt")

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

function test41_IO_validation(){
  header "TEST41: input known text with known encoding."

  INPUT_FILE=$(echo $PROGRAM_NAME | perl -pi -e 's/..(.*)2(.*).*/\1/g' -X)
  OUTPUT_FILE=$(echo $PROGRAM_NAME | perl -pi -e 's/..(.*)2(.*).*/\2/g' -X)

  $PROGRAM_NAME -i $TEST_DIR/loremipsum_${INPUT_FILE}.txt -o $TEST_DIR/loremipsum_out.txt;

  diff_result="$(diff $TEST_DIR/loremipsum_out.txt $TEST_DIR/loremipsum_${OUTPUT_FILE}.txt)";

  if [[ -z ${diff_result} ]]; then :;
    IO_validation_passed "No differences.";
  else
    IO_validation_failed "Differences: \n${diff_result}";
    failedTests=$(($failedTests+1));
  fi

  rm -f $TEST_DIR/loremipsum_out.txt
}

function test42_IO_validation(){
  header "TEST42: verifying the correct output."

  INPUT_FILE=$(echo $PROGRAM_NAME | perl -pi -e 's/..(.*)2(.*).*/\1/g' -X);
  OUTPUT_FILE=$(echo $PROGRAM_NAME | perl -pi -e 's/..(.*)2(.*).*/\2/g' -X);

  program_output="$($PROGRAM_NAME -i $TEST_DIR/${INPUT_FILE}.txt -o - | od -t c)";
  correct_output="$(od -t c $TEST_DIR/${OUTPUT_FILE}.txt)";
  diff_result="$(diff  <(echo $program_output ) <(echo $correct_output))";

  if [[ -z ${diff_result} ]]; then :;
    IO_validation_passed "No differences.";
  else
    IO_validation_failed "Differences: \n${diff_result}";
    failedTests=$(($failedTests+1));
  fi
}

function test43_IO_validation(){
  header "TEST43: input-output should be the same."

  # Running 'nLimit' attempts for the input size 'n'
  n=1;
  nLimit=$((1024*n));

  msg_testing "$PROGRAM_ENC -i $TEST_DIR/input.n.u -o $TEST_DIR/output.n.d"
  msg_testing "$PROGRAM_DEC -i $TEST_DIR/output.n.d -o $TEST_DIR/output.n.u"

  while [ $n -le $nLimit ]
  do
    head -c $n </dev/urandom >$TEST_DIR/input.$n.u;

    $PROGRAM_ENC -i $TEST_DIR/input.$n.u -o $TEST_DIR/output.$n.d;
    $PROGRAM_DEC -i $TEST_DIR/output.$n.d -o $TEST_DIR/output.$n.u;

    diff_result="$(diff -q $TEST_DIR/input.$n.u $TEST_DIR/output.$n.u)";

    if [[ -z ${diff_result} ]]; then :;
      IO_validation_passed "n = $n";
    else
      IO_validation_failed "n = $n";
      error_msg "input.$n.u";
      cat $TEST_DIR/input.$n.u | od -A x -t x1z -v;
      error_msg "output.$n.d";
      cat $TEST_DIR/output.$n.d | od -A x -t x1z -v;
      error_msg "output.$n.u";
      cat $TEST_DIR/output.$n.u | od -A x -t x1z -v;
      failedTests=$(($failedTests+1));
      break;
    fi

    n=$(($n*2));
  done

  rm -f $TEST_DIR/input.*.u $TEST_DIR/output.*.d $TEST_DIR/output.*.u
}

function test44_IO_validation(){
  header "TEST44: Check bit by bit."

  msg_testing "(echo \"Uno\"; echo \"Dos\"; echo \"Tres\") | $PROGRAM_ENC | $PROGRAM_DEC | od -t c"
  program_output="$((echo "Uno"; echo "Dos"; echo "Tres") | $PROGRAM_ENC | $PROGRAM_DEC | od -t c)";
  correct_output="0000000 U n o \n D o s \n T r e s \n 0000015";
  diff_result="$(diff  <(echo $program_output ) <(echo $correct_output))";

  if [[ -z ${diff_result} ]]; then :;
    IO_validation_passed "No differences.";
  else
    IO_validation_failed "Differences: \n${diff_result}";
    failedTests=$(($failedTests+1));
  fi
}

function test45_IO_validation(){
  header "TEST45: Check max line length and number of encoded bytes."

  program_output_line_count="$(echo -n "$(yes | head -c 1024 | $PROGRAM_ENC)" | wc -l | tr -d ' ')";

  # 1024 bytes[unix] => 8192 bits
  # charEachLine[unix] => 'y' + '\n'
  # charEachLine[dos] => 'y' + '\n' + '\r'
  # floor(1024 bytes[dos] /  charEachLine) => 511 lines
  correct_output_line_count="511";
  diff_result_line_count="$(diff  <(echo "$program_output_line_count" ) <(echo "$correct_output_line_count"))";

  if [[ -z ${diff_result_line_count} ]]; then :;
    IO_validation_passed "No differences in line count.";
  else
    IO_validation_failed "Differences in line count:
    Program output:${program_output_line_count}
    Correct output:${correct_output_line_count}";
    failedTests=$(($failedTests+1));
  fi

  # Check encoded bytes
  program_output_word_count="$(yes | head -c 1024 | $PROGRAM_ENC | $PROGRAM_DEC | wc -c | tr -d ' ')";
  correct_output_word_count="1024";
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
function test5_encoding_execution_times(){
  header "TEST5: encoding execution times."

  n=1;
  nLimit=$((1024*10000));
  rm -f $TEST_DIR/encodingTimes.txt

  while [ $n -le $nLimit ]
  do
    head -c $n </dev/urandom >$TEST_DIR/in.$n.u;
    ts=$(date +%s%N);
    $PROGRAM_ENC -i $TEST_DIR/in.$n.u -o $TEST_DIR/out.$n.d;
    tt=$((($(date +%s%N) - $ts)/1000000));

    printf 'n: %-10d %10s %.2f [ms]\n' "$n" " " "$tt"
    printf '%-10d %.2f\n' "$n" "$tt" >> $TEST_DIR/encodingTimes.txt

    rm -f $TEST_DIR/in.$n.u $TEST_DIR/out.$n.d

    n=$((n*2));

  done
}

function test6_decoding_execution_times(){
  header "TEST6: decoding execution times."

  n=1;
  nLimit=$((1024*10000));
  rm -f $TEST_DIR/decodingTimes.txt

  while [ $n -le $nLimit ]
  do
    head -c $n </dev/urandom >$TEST_DIR/in.$n.u;
    $PROGRAM_ENC -i $TEST_DIR/in.$n.u -o $TEST_DIR/out.$n.d;
    ts=$(date +%s%N);
    $PROGRAM_DEC -i $TEST_DIR/out.$n.d -o $TEST_DIR/out.$n.u;
    tt=$((($(date +%s%N) - $ts)/1000000));

    printf 'n: %-10d %10s %.2f [ms]\n' "$n" " " "$tt"
    printf '%-10d %.2f\n' "$n" "$tt" >> $TEST_DIR/decodingTimes.txt

    rm -f $TEST_DIR/in.$n.u $TEST_DIR/out.$n.d $TEST_DIR/out.$n.u

    n=$((n*2));

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
test3_valid_parameters
test41_IO_validation
test42_IO_validation

# ------------------------------------------------------------
# Run the tests. Program dos2unix
# ------------------------------------------------------------

# Program name to test.
PROGRAM_NAME='./dos2unix'

test1_parameter_input_inexistent_stream
test12_parameter_input_invalid_stream
test2_parameter_output_stream
test3_valid_parameters
test41_IO_validation
test42_IO_validation

# ------------------------------------------------------------
# Run encoding-decoding tests.
# ------------------------------------------------------------
PROGRAM_ENC='./unix2dos'
PROGRAM_DEC='./dos2unix'

test43_IO_validation
test44_IO_validation
test45_IO_validation

test5_encoding_execution_times
test6_decoding_execution_times

header "Test suite ended."

if [[ $failedTests -eq $zero ]]; then
  success_msg "All tests passed.";
else
  error_msg "Failed tests: $failedTests";
fi
