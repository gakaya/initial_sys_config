#!/usr/bin/env bash
#
# Install the JAVA JDK in a CentOS System.
# must include both java packages:
# - java-1.8.0-openjdk 
# - java-1.8.0-openjdk-devel
#
# Last updated: Sun 2018Mar11 12:41:16 PDT 
#

echo
echo "#######################################"
echo "SCRIPT: $0                             "
echo "Installing ANT on CentOS7..."
echo "#######################################"
echo

ANT_VERSION='1.10.2' #ONLY THE LATEST BIN is available

function cleanUpPrevious(){
  rm -rf /usr/local/apache-ant*
  rm -rf /usr/local/ant
  rm -rf /usr/local/bin/ant 
  rm -rf /usr/local/ant/bin/ant 
}

function install_packages(){
  echo "INFO: Installing ANT..."

  cd /usr/local
  wget http://www.us.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz
  tar xzvf apache-ant-${ANT_VERSION}-bin.tar.gz
  ln -s /usr/local/apache-ant-${ANT_VERSION} /usr/local/ant
  sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
  ln -s /usr/local/ant/bin/ant /usr/local/bin/ant
  cd

}

########################################
# MAIN PROGRAM
#
# check whether JDK is installed. Install it if not already there.
ant -version 2> /dev/null
if [ $? == 0 ]; then
  echo "Ant is already installed"
  exit 0
else
  cleanUpPrevious
  install_packages
  echo; echo "DONE Installing $ANT_VERSION..."; echo
fi
