#!/usr/bin/env bash
#
# https://pkg.jenkins.io/redhat-stable/...
# http://www.unix.com/shell-programming-and-scripting/249212-sed-command-replace-line-file-using-line-number-output-pipe.html
# https://unix.stackexchange.com/questions/69112/how-can-i-use-variables-when-doing-a-sed
#

echo
echo "#######################################"
echo "SCRIPT: $0                             "
echo "Installing CentOS7 Jenkins..."
echo "#######################################"
echo

_YUM="yum install --nogpgcheck -y"
OS_VERSION=`cat /etc/redhat-release | awk '{print $4}'`
JENKINS_VERSION='jenkins-2.19.4-1.1'
OS=7

# Get the jenkins repo
function jenkins_repo() {
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
}

function install_jenkins(){
  echo "INFO: Installing Jenkins"
  $_YUM $JENKINS_VERSION
}

# Start the jenkins service.
function jenkins_service() {
  if [[ "$OS_VERSION" > "$OS" ]] ; then
      #for Centos 7
      systemctl start jenkins
      systemctl enable jenkins
      systemctl status jenkins
  else
      #for Centos 6
      service jenkins start
      service jenkins status
      chkconfig jenkins on
  fi
  echo
  echo "Start jenkins on CentOS version $OS_VERSION"
  echo 'Visit the WebGUI at: http://<server>:8080/'
  echo
}

# For the jenkins user, change the shell from false to true so we can login as
# the jenkins user to create its SSH key. First find the LINE in /etc/passwd
# that has the jenkins user and use that in the sed command.
function change_shell (){
  PASSWD=/etc/passwd
  cp $PASSWD $PASSWD.$$
  LINE=`grep -n ^jenkins $PASSWD | awk -F: '{print $1}'`
  sed -i "${LINE}s/false/true/" $PASSWD
}

# Ensure java is installed before installing jenkins.
function java_check () {
java -version 2> /dev/null
if [ $? == 0 ]; then
  echo
  echo "INFO :: Java is installed. Good to go. "
  echo
else
  echo
  echo "ERROR :: Java is not installed. Install the JDK before installing Jenkins."
  echo
  exit 1;
fi
}

########################################
# MAIN PROGRAM
#
java_check
jenkins_repo
install_jenkins
jenkins_service
change_shell
