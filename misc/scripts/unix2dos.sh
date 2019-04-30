#!/bin/bash

OPT_IN="$1"
OPT_OUT="$3"
# Unix to Windows-DOS

if [ "$OPT_IN" == "-i" ]; then
  INPUT="$2";
else
  INPUT="$1";
fi

if [ "$OPT_OUT" == "-o" ]; then
  OUTPUT="$4";
fi

if [[ -z $OUTPUT  ]]; then
  awk 'sub("$", "\r")' "$INPUT" 
else
  awk 'sub("$", "\r")' "$INPUT" > "$OUTPUT"
fi

