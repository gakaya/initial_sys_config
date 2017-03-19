#!/usr/bin/env bash

echo 
echo "#####################################"
echo "SCRIPT: $0"
echo "Installing PYTHON Packages..."
echo "#####################################"
echo

echo "Installing Python..."
yum install python python-pip python-tools python-devel -y > /dev/null 

echo "Upgrading PIP..."
/bin/pip install --upgrade pip > /dev/null

echo "Installing python modules..."
/bin/pip install passlib > /dev/null #to generate encrypted password

echo; echo "DONE Installing PYTHON Packages..."; echo
