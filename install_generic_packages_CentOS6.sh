#!/usr/bin/env bash

echo 
echo "######################################"
echo "SCRIPT: $0"
echo "Installing CentOS6 GENERIC Packages..."
echo "######################################"
echo

_YUM="yum install --nogpgcheck"

function install_packages(){
  echo "Cleaning up yum cache..."
  $_YUM clean all

  echo "Installing EPEL..."
  $_YUM epel-release -y > /dev/null
  
  echo "Installing Kernel Headers and Devel..."
  $_YUM kernel-headers kernel-devel-2.6.32-573.el6.x86_64 kernel-devel-2.6.32-573.8.1.el6.x86_64 -y > /dev/null
  
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

function perl_install(){
  echo "Installing PERL... not installed by default on CentOS6."
  $_YUM perl -y > /dev/null
}  

function update_system(){
  echo "Doing a full system update... wait a few mins..."
  yum update -y > /dev/null
}

function disable_selinux() {
  echo "Disabling SELinux..."
  cp /etc/selinux/config /etc/selinux/config.ORIG
  perl -pi -e 's/=permissive/=disabled/' /etc/selinux/config
  setenforce 0
}

function sudo_config(){
  FILE="/etc/sudoers"
  cp $FILE $FILE.ORIG
  perl -pi -e 's/^%wheel/#wheel/' $FILE
  perl -pi -e 's/^#\s%wheel(.*)/%wheel$1/' $FILE
}  

########################################
# MAIN PROGRAM
#
install_packages
perl_install
disable_selinux
sudo_config
#update_system

echo "Updating the local file database... will taka a couple of mins."
updatedb

echo; echo "DONE Installing GENERIC Packages..."; echo
