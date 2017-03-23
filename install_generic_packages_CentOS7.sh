#!/usr/bin/env bash

echo 
echo "######################################"
echo "SCRIPT: $0"
echo "Installing CentOS7 GENERIC Packages..."
echo "######################################"
echo

_YUM="yum install --nogpgcheck"

function install_packages(){
  echo "Cleaning up yum cache..."
  yum clean all

  echo "Installing EPEL..."
  $_YUM epel-release -y > /dev/null
  
  echo "Installing Kernel Headers and Devel..."
  $_YUM kernel-headers kernel-devel  -y > /dev/null
  
  echo "Installing Java JDK"
  $_YUM java-1.8.0-openjdk-devel -y > /dev/null
  
  echo "Installing gcc..."
  $_YUM gcc gcc glibc glibc-common glibc-devel glibc-headers -y > /dev/null
  
  echo "Installing zlib..."
  $_YUM zlib-devel -y > /dev/null
  
  echo "Installing nfs utilities..."
  $_YUM bind-utils -y > /dev/null
  
  echo "Installing misc utilities..."
  $_YUM vim-enhanced mlocate tcpdump nc strace screen vim mailx traceroute tree telnet nmap libxml2 pciutils git -y > /dev/null
  
  echo "Installing expect... for the mkpasswd command."
  $_YUM expect -y > /dev/null
}

function update_system(){
  echo "Doing a full system update... wait a few mins..."
  yum update -y > /dev/null
}

function disable_selinux() {
  echo "Disabling SELinux..."
  /bin/cp /etc/selinux/config /etc/selinux/config.ORIG
  /bin/perl -pi -e 's/=permissive/=disabled/' /etc/selinux/config
  /sbin/setenforce 0
}

function sudo_config(){
  FILE="/etc/sudoers"
  /bin/cp $FILE $FILE.ORIG
  /bin/perl -pi -e 's/^%wheel/#wheel/' $FILE
  /bin/perl -pi -e 's/^#\s%wheel(.*)/%wheel$1/' $FILE
}  

########################################
# MAIN PROGRAM
#
install_packages
disable_selinux
sudo_config
#update_system

echo "Updating the local file database... will taka a couple of mins."
updatedb

echo; echo "DONE Installing GENERIC Packages..."; echo
