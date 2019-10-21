#!/bin/bash
## remove users when I've messed up the configuration

n=40
for i in `seq -w 1 ${n}`
do
  echo $i;
  userdel -rf user${i}
done;
