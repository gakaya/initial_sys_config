#!/usr/bin/env bash
#
# Install Apache Maven in a CentOS system
# Sun Sep 24 18:17:04 PDT 2017
#

echo
echo "#######################################"
echo "SCRIPT: $0                             "
echo "Installing CentOS7 Apache MAVEN...     "
echo "#######################################"
echo

VERSION='3.3.9'

# install the package
function install_packages(){
   echo
   echo "INFO: Installing Apache MAVEN ${VERSION}..."
   wget http://mirror.cc.columbia.edu/pub/software/apache/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz
   tar xzf apache-maven-$VERSION-bin.tar.gz -C /usr/local
   cd /usr/local
   ln -s apache-maven-$VERSION maven
   ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn
   echo "Updating the local file database... will taka a couple of mins."
   updatedb
   echo; echo "DONE Installing Apache MAVEN ${VERSION}..."
}

function verify_installation(){
  /usr/local/maven/bin/mvn --version
  if [ $? == 0 ]; then
    echo; echo "INFO: Maven installation succeded."
  else
    echo; echo "ERROR: No Maven installation found."
  fi
}

# create a profile file to setup the env vars
function setup_env_vars(){
  PROFILE=/etc/profile.d/maven.sh
  cp /dev/null ${PROFILE}
  echo "export M2_HOME=/usr/local/apache-maven-${VERSION}" >> ${PROFILE}
  echo "export PATH=${M2_HOME}/bin:${PATH}" >> ${PROFILE}
}

#check whether JDK is installed. Install it if not already there.
function java_check(){
java -version 2> /dev/null
if [ $? != 0 ]; then
   echo; echo "Java is is not installed. Install the JDK first, then rerun this script."
   exit 0
fi
}

## Remove the installation
#function uninstall_maven(){
#  rm -rf /usr/local/maven
#  rm -rf /usr/local/apache-maven-${VERSION}
#}

echo
java_check
install_packages
setup_env_vars
verify_installation
echo
