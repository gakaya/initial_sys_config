#!/usr/bin/env bash
#
# https://pkg.jenkins.io/redhat-stable/...
# http://www.unix.com/shell-programming-and-scripting/249212-sed-command-replace-line-file-using-line-number-output-pipe.html
# https://unix.stackexchange.com/questions/69112/how-can-i-use-variables-when-doing-a-sed
#
# Date: Sun Dec 31 21:40:01 PST 2017  (this timestamp is not a mistake..)
#

_YUM="yum install --nogpgcheck -y"
OS_VERSION=`cat /etc/redhat-release | awk '{print $4}'`
DOCKER_VERSION='docker-ce-17.12.0.ce'
OS=7

echo
echo "#######################################"
echo "SCRIPT: $0                             "
echo "Installing $DOCKER_VERSION..."
echo "#######################################"
echo

# Remove anything previously installed
function docker_cleanup {
yum -y remove $DOCKER_VERSION \
    docker-common \
    docker-selinux \
    docker-engine \
    2> /dev/null
}

# Get the docker repo
function docker_repo() {
  sudo $_YUM yum-utils device-mapper-persistent-data lvm2
  sudo /bin/yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  if [ $? != 0 ]; then
     echo "ERROR :: Failed to add docker repo."
     exit 1
  fi
}

# Install docker
function docker_install(){
  echo "INFO: Installing docker"
  $_YUM $DOCKER_VERSION
}

# Start the docker service.
function docker_service() {
  rpm -qa | grep docker
  if [ $? != 0 ]; then
    echo -e "\nERROR :: Docker is not installed. Service not started."
    exit 1
  fi

  if [[ "$OS_VERSION" > "$OS" ]] ; then
      #for Centos 7
      systemctl start docker
      systemctl enable docker
      systemctl status docker
  else
      #for Centos 6
      /sbin/service docker start
      /sbin/service docker status
      /sbin/chkconfig docker on
  fi
  echo
  echo "Start docker on CentOS version $OS_VERSION"
  echo
}

# Pull down a test image to ensure docker works
function docker_validate {
    # remove the test image if present
    docker image ls hello-world | grep hello
    if [ $? == 0 ]; then
      docker rmi hello-world --force
    fi

    # pull down the test image
    docker run hello-world
    if [ $? != 0 ]; then
      echo -e "\nERROR :: Could not start test container \"hello-world\"."
      exit 1
    fi
}
# Ensure java is installed before installing docker.
function java_check () {
java -version 2> /dev/null
if [ $? == 0 ]; then
  echo
  echo "INFO :: Java is installed. Good to go. "
  echo
else
  echo
  echo "ERROR :: Java is not installed. Install the JDK before installing $DOCKER_VERSION."
  echo
  exit 1;
fi
}

########################################
# MAIN PROGRAM
#
java_check
docker_cleanup
docker_repo
docker_install
docker_service
docker_validate
