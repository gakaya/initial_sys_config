#!/usr/bin/env bash
#
# Install the JAVA JDK in a CentOS System.
# must include both java packages:
# - java-1.8.0-openjdk 
# - java-1.8.0-openjdk-devel
#
# Last updated: Sun Sep 24 13:25:42 PDT 2017
# Last updated: Sat Mar  3 20:21:23 PST 2018
#

echo
echo "#######################################"
echo "SCRIPT: $0                             "
echo "Installing CentOS7 JAVA JDK Packages..."
echo "#######################################"
echo

_YUM="yum install --nogpgcheck"
JAVA_VERSION='java-1.8.0-openjdk java-1.8.0-openjdk-devel'

function install_packages(){
  echo "INFO: Installing Java JDK"
  $_YUM $JAVA_VERSION -y > /dev/null

  echo "INFO: Configure java alternatives"
  alternatives --install /usr/bin/java java /usr/java/latest/bin/java 200000
  alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
  alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000
  echo "export JAVA_HOME=/usr/java/latest" >> /etc/rc.d/rc.local
}

########################################
# MAIN PROGRAM
#
# check whether JDK is installed. Install it if not already there.
java -version 2> /dev/null
if [ $? == 0 ]; then
  echo "Java is already installed"
  exit 0
else
  install_packages
  echo "Updating the local file database... will taka a couple of mins."
  updatedb
  echo; echo "DONE Installing $JAVA_VERSION..."; echo
fi
