#!/bin/bash
#
# Creates the .ssh directory, the authorized_keys and a RSA key
# Date: Tue Dec 20 18:46:47 PST 2016
#
# http://unix.stackexchange.com/questions/69314/automated-ssh-keygen-without-passphrase-how
#

user=devuser
home=/home/$user

function create_ssh(){
  home=$1

  echo -e "\nStart: create ssh rsa key..."

  if [ ! -f $home/.ssh ];then
    mkdir $home/.ssh
  fi

  chmod 700 $home/.ssh

  cd $home/.ssh
  touch authorized_keys
  chmod 600 authorized_keys

  cat /dev/zero | ssh-keygen -q -N "" #creates rsa key, no passphrase


  echo -e "\nEnd: create ssh rsa key...\n"
}

#####################
# MAIN PROGRAM
# 
create_ssh $home
