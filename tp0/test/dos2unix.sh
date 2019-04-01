#!/bin/bash

# Windows-DOS to Unix
OPT_IN="$1"
OPT_OUT="$3"

if [ "$OPT_IN" == "-i" ]; then
  INPUT="$2";
else
  INPUT="$1";
fi

if [ "$OPT_OUT" == "-o" ]; then
  OUTPUT="$4";
fi

if [[ -z $OUTPUT  ]]; then
  awk '{ sub("\r$", ""); print }' "$INPUT" 
else
  awk '{ sub("\r$", ""); print }' "$INPUT" > "$OUTPUT"
fi
