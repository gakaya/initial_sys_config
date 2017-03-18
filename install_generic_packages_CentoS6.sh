#!/usr/bin/env bash

echo 
echo "#####################################"
echo "SCRIPT: $0"
echo "Installing GENERIC Packages..."
echo "#####################################"
echo

echo "Installing Kernel Headers and Devel..."
yum install kernel-headers kernel-devel-2.6.32-573.el6.x86_64 kernel-devel-2.6.32-573.8.1.el6.x86_64 -y > /dev/null

echo "Installing Java JDK"
yum install java-1.8.0-openjdk-devel -y > /dev/null

echo "Installing gcc..."
yum install gcc gcc glibc glibc-common glibc-devel glibc-headers -y > /dev/null

echo "Installing zlib..."
yum install zlib-devel -y > /dev/null

echo "Installing nfs utilities..."
yum install bind-utils -y > /dev/null

echo "Installing misc utilities..."
yum install vim-enhanced  mlocate tcpdump nc strace screen vim mailx traceroute tree telnet nmap libxml2 pciutils git -y > /dev/null

echo "Installing RUBY..."
yum --disablerepo=epel --disablerepo=rpmforge install ruby ruby-devel ruby-irb ruby-libs ruby-ri rubygems rubygems-devel rubygem-rake  -y > /dev/null

echo "Installing Python..."
yum install python -y

echo "Installing Perl CPAN packages..."
yum install perl-CPAN perl-CPANPLUS -y

echo "Installing Perl MySQL packages..."
yum install perl-DBI perl-DBD-MySQL perl-DBD-Pg -y 

echo "Updating the local file database... will taka a couple of mins."
updatedb

echo; echo "DONE Installing GENERIC Packages..."; echo
