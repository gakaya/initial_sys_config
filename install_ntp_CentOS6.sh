#!/usr/bin/env bash
#
# Install NTP on Centos6
#

_YUM="yum install --nogpgcheck"

function ntp_install() {
  echo; echo "Installing NTP on CentOS6"; echo 
  $_YUM ntp -y > /dev/null
  
  # Set to PST
  mv /etc/localtime /etc/localtime.ORIG
  ln -s /usr/share/zoneinfo/US/Pacific  /etc/localtime
  
  # start the service
  chkconfig ntpd on
  service ntpd start
  
  # check
  ntpq -p 
  
  echo "DONE Installing NTP"; echo 
}

##########################################
# MAIN PROGRAM
#
ntp_install
