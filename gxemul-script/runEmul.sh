#!/bin/bash

# To execute, run:
# chmod u+x runEmul.sh
# ./runEmul.sh

sudo ifconfig lo:0 172.20.0.1
./xgxemul -e 3max -d netbsd-pmax.img -x
