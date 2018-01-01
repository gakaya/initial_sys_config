#!/usr/bin/env bash

echo
echo "######################################"
echo "SCRIPT: $0"
echo "Installing CentOS7 GENERIC Packages..."
echo "######################################"
echo

_YUM="yum install --nogpgcheck"
GCC='gcc gcc glibc glibc-common glibc-devel glibc-headers'
ZLIB='zlib-devel'
MISC_UTILS='net-utils elinks bridge-utils bind-utils vim-enhanced mlocate tcpdump nc strace screen tmux mailx traceroute tree telnet nmap libxml2 pciutils git expect'

function install_packages(){
  echo "Cleaning up yum cache..."
  yum clean all
  rm -rf /var/cache/yum

  echo "Installing EPEL..."
  $_YUM epel-release -y > /dev/null

  echo "Installing Kernel Headers and Devel..."
  $_YUM kernel-headers kernel-devel --disableexcludes=all  -y > /dev/null

  echo "Installing gcc..."
  $_YUM $GCC -y > /dev/null

  echo "Installing zlib..."
  $_YUM $ZLIB -y > /dev/null

  echo "Installing misc utilities..."
  $_YUM  $MISC_UTILS -y > /dev/null
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
update_system

echo "Updating the local file database... will taka a couple of mins."
updatedb

echo; echo "DONE Installing GENERIC Packages..."; echo
