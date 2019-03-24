#!/bin/bash

# Unix to Windows-DOS
awk 'sub("$", "\r")' $1 > $2
