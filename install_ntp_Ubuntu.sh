#!/usr/bin/env bash
#
# Install NTP on Ubuntu/Debian
#

function ntp_install() {
  echo; echo "Installing NTP on Ubuntu/Debian"; echo 
  apt-get update  > /dev/nulld
  apt-get install ntp ntpdate

  service ntp start
  service ntp stop
  service ntp status

  # Set to PST
  timedatectl set-timezone America/Tijuana
  
  # check
  ntpq -p 
  
  echo "DONE Installing NTP"; echo 
}

##########################################
# MAIN PROGRAM
#
ntp_install
