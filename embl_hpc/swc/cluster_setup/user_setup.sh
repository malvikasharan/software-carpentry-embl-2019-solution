#!/bin/bash
## script to create 40 users called userXX with a default password
## and setup up ssh logins without asking for passwords & host checking

n=40
for i in `seq -w 1 ${n}`
do
  echo $i;

  ## create n new user called userXX and create default password
  adduser --gecos "" --disabled-password user${i}
  echo user${i}:SoftwareC | chpasswd

  ## create somewhere to store ssh configuration
  mkdir -p /home/user${i}/.ssh
  printf "Host *\n  StrictHostKeyChecking no\n  ForwardX11 yes\n" > /home/user${i}/.ssh/config

  ## generate a ssh key & copy to the list of authorized keys
  ssh-keygen -f /home/user${i}/.ssh/id_rsa -t rsa -N ''
  cp /home/user${i}/.ssh/id_rsa.pub /home/user${i}/.ssh/authorized_keys

  ## set new user as owner
  chown -R user${i}:user${i} /home/user${i}/.ssh
  chmod 600 /home/user${i}/.ssh/config

done
