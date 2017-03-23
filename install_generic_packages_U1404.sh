#!/usr/bin/env bash

echo 
echo "######################################"
echo "SCRIPT: $0"
echo "Installing Ubuntu 14.04 GENERIC Packages..."
echo "######################################"
echo

_APT_GET=" apt-get install -y"

function install_packages(){
  echo "Updating the database..."
  apt-get update > /dev/null

  echo "Installing git..."
  $_APT_GET git > /dev/null
}

function install_gcc() {
  echo "Installing lib6..."
  $_APT_GET libc6 > /dev/null

  echo "Installing g++..."
  yes '' | add-apt-repository ppa:ubuntu-toolchain-r/test
  $_APT_GET g++ > /dev/null
}  

function update_system(){
  echo "Doing a full system update... wait a few mins..."
  $_APT_GET upgrade  > /dev/null
}

########################################
# MAIN PROGRAM
#
install_packages
install_gcc
#update_system

echo; echo "DONE Installing U1404 GENERIC Packages..."; echo
