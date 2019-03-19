#!/bin/bash
# chmod u+x mountGuestFSRoot.sh
# ./mountGuestFSRoot.sh

sudo sshfs -p 2222 -C root@127.0.0.1:/root $(pwd)/guestFS
