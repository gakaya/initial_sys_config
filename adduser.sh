#!/bin/bash
#
# This script creates a user and adds it to the wheel group.
# It creates the user ssh key and adds it to the user's authorized_keys
# and does ssh to the localhost in order to add it to the known_hosts
# and then the user can do passwordless ssh to the localhost.
# The end result is that this user can run Ansible playbooks.
#
# (!) The hashed password is 'password' without the single quotes
#
# (!) Do not use uppwercase for the gid and uid
#
# Another way to generate a random number:
#   uid=shuf -i 2000-2100 -n 1
#
# Created: Tue Mar 21 10:29:59 PDT 2017
#


user="devuser"                   #user name

function add_user() {
  USER=$1                      #user name
  uid=$((2000 + RANDOM % 100)) #user numeric id
  gid=$((uid + 1))             #user group id

  echo
  echo "Adding $USER... the password is \"password\""
  echo
  echo "$USER:x:$uid:$gid::/home/$USER:/bin/bash" >> /etc/passwd
  echo "$USER:x:$gid:" >> /etc/group
  echo "$USER:$6$siYPS/XT$Y8oPgkOi4gLLnlsb5L6ikyRfNLJGB4ymrO0SqhtyeE9RFBZV.OQCqVVl0cqoQddgDHnNdzFBNz0H7neGJ9RPH1:17246:0:99999:7:::" >> /etc/shadow

  # add the user to the wheel sudo group
  usermod -a -G wheel $USER

  # create the home dir
  mkdir -p /home/$USER/.ssh

  # create SSH files and set perms
  touch /home/$USER/.ssh/authorized_keys
  touch /home/$USER/.ssh/known_hosts
  chmod 700 /home/$USER/.ssh
  chmod 600 /home/$USER/.ssh/authorized_keys

  # create the ssh key with empty passphrase
  ssh-keygen -t rsa -N "" -f /home/$USER/.ssh/id_rsa
  chown -R $USER:$USER /home/$USER

  # add the user key to the authorized_keys
  # the ssh test to localhost adds the key to the known_hosts file
  # after this, the user can do ssh commands freely
  cat /home/$USER/.ssh/id_rsa.pub >> /home/$USER/.ssh/authorized_keys
  sudo su - $USER -c 'ssh localhost  -o "StrictHostKeyChecking no"'
}

add_user $user