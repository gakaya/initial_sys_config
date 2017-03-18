#!/usr/bin/env bash

echo; echo "Installing APACHE..."; echo
yum install httpd-devel -y > /dev/null
# Do not start the service automatically on start up to speed up 
# the start up process and to prevent issue with memory
#chkconfig httpd on
#service httpd start
echo "DONE Installing APACHE..."; echo
