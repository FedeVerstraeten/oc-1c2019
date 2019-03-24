#!/bin/bash

# Windows-DOS to Unix
awk '{ sub("\r$", ""); print }' $1 > $2
