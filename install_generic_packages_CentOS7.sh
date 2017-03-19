#!/usr/bin/env bash

echo 
echo "######################################"
echo "SCRIPT: $0"
echo "Installing CentOS7 GENERIC Packages..."
echo "######################################"
echo

echo "Installing EPEL..."
yum install epel-release -y > /dev/null

echo "Installing Kernel Headers and Devel..."
yum install kernel-headers kernel-devel  -y > /dev/null

echo "Installing Java JDK"
yum install java-1.8.0-openjdk-devel -y > /dev/null

echo "Installing gcc..."
yum install gcc gcc glibc glibc-common glibc-devel glibc-headers -y > /dev/null

echo "Installing zlib..."
yum install zlib-devel -y > /dev/null

echo "Installing nfs utilities..."
yum install bind-utils -y > /dev/null

echo "Installing misc utilities..."
yum install vim-enhanced mlocate tcpdump nc strace screen vim mailx traceroute tree telnet nmap libxml2 pciutils git -y > /dev/null

echo "Installing expect... for the mkpasswd command."
yum install expect -y > /dev/null

echo "Doing a full system update... wait a few mins..."
yum update -y > /dev/null

echo "Updating the local file database... will taka a couple of mins."
updatedb

echo; echo "DONE Installing GENERIC Packages..."; echo
