#!/usr/bin/env bash

echo 
echo "######################################"
echo "SCRIPT: $0"
echo "Installing Ubuntu 14.04 JDK Packages..."
echo "######################################"
echo

_APT_GET=" apt-get install -y"

function install_packages(){
  echo "Updating the datbase..."
  yes '' | add-apt-repository ppa:webupd8team/java
  apt-get -y -q update
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
  yes '' | apt-get -y -q install oracle-java8-installer
  yes '' | apt-get -y -q install oracle-java7-installer
  update-java-alternatives -s java-8-oracle
}

########################################
# MAIN PROGRAM
#
install_packages

echo; echo "DONE Installing U1404 JDK Packages..."; echo
