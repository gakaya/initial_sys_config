#!/usr/bin/env bash

echo 
echo "######################################"
echo "SCRIPT: $0"
echo "Installing ANSIBLE..."
echo "######################################"
echo

_YUM="yum install -y --nogpgcheck"

function ansible_install(){
  echo "Cleaning up yum cache..."
  yum clean all
  $_YUM ansible 
}

########################################
# MAIN PROGRAM
#
ansible_install

echo "Updating the local file database... will taka a couple of mins."
updatedb

echo; echo "DONE Installing ANSIBLE..."; echo
