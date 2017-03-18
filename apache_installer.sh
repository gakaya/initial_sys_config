#!/usr/bin/env bash
#
echo "Installing Apache and setting it up..."
yum install httpd -y >/dev/null 2>&1
rm -rf /var/www
mkdir /var/www
ln -fs /vagrant /var/www/html
#service httpd start
#chkconfig httpd on
echo "Hello, World!" > /var/www/html/index.html
