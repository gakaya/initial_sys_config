#!/usr/bin/env bash

echo 
echo "#####################################"
echo "SCRIPT: $0"
echo "Installing PYTHON Packages..."
echo "#####################################"
echo

_YUM="yum install --nogpgcheck"

function install_python() {
  echo "Installing Python..."
  $_YUM python python-pip python-tools python-devel -y > /dev/null 

  echo "Upgrading PIP..."
  /bin/pip install --upgrade pip > /dev/null

  echo "Installing python modules..."
  /bin/pip install passlib > /dev/null #to generate encrypted password

  echo; echo "DONE Installing PYTHON Packages..."; echo
}

install_python
