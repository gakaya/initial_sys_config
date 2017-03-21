#!/usr/bin/env bash
#
# Install NTP on Centos7
#

_YUM="yum install --nogpgcheck"

function ntp_install() {
  echo; echo "Installing NTP on CentOS7"; echo 
  $_YUM ntp -y > /dev/null
  
  # Set to PST
  mv /etc/localtime /etc/localtime.ORIG
  ln -s /usr/share/zoneinfo/US/Pacific  /etc/localtime
  
  # start the service
  systemctl start ntpd
  systemctl enable ntpd
  
  # check
  systemctl list-units --type service --all | grep ntp
  
  echo "DONE Installing NTP"; echo 
}

##########################################
# MAIN PROGRAM
#
ntp_install
