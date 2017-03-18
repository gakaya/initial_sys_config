#!/usr/bin/env bash

echo; echo "Installing NTP"; echo 

yum install ntp -y > /dev/null

# Set to PST
mv /etc/localtime /etc/localtime.ORIG
ln -s /usr/share/zoneinfo/US/Pacific  /etc/localtime

# start the service
chkconfig ntpd on
service ntpd start

echo "DONE Installing NTP"; echo 
