#!/bin/bash
## Run this on each compute node
## script creates 40 users called userXX with a default password
## and setup up ssh logins without asking for passwords & host checking

n=40
for i in `seq -w 1 ${n}`
do
  echo $i;

  ## create n new user called userXX and create default password
  adduser --gecos "" --disabled-password user${i}
  echo user${i}:SoftwareC | chpasswd

done
