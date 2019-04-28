#!/bin/bash
n=0; while :; do
  n="`expr $n + 1`";
  head -c 100 </dev/urandom >/tmp/test.$n.u;
  ./unix2dos </tmp/test.$n.u >/tmp/test.$n.d || break;
  ./dos2unix </tmp/test.$n.d >/tmp/test.$n.2.u || break;
  diff -q /tmp/test.$n.u /tmp/test.$n.2.u || break;
  rm -f /tmp/test.$n.*;
  echo Ok: $n;
done; echo Error: $n

