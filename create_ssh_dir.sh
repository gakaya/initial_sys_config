#!/bin/bash
#
# Creates the .ssh directory, the authorized_keys and a RSA key
# Date: Tue Dec 20 18:46:47 PST 2016
#
# http://unix.stackexchange.com/questions/69314/automated-ssh-keygen-without-passphrase-how
#

echo -e "\nStart: create ssh rsa key..."
cd $HOME
mkdir ~/.ssh
chmod 700 ~/.ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys
echo
cat /dev/zero | ssh-keygen -q -N "" #creates rsa key, no passphrase
echo
cat id_rsa.pub
echo -e "\nEnd: create ssh rsa key...\n"
