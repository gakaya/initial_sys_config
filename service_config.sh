#!/usr/bin/env bash
#
# Configure misc services
#

echo; echo "Running Server Configs...";echo

service_iptables (){
  # iptables - disable
  chkconfig iptables off
  service iptables stop

  # selinux - disable
  perl -pi -e s/SELINUX=permissive/SELINUX=disabled/ /etc/sysconfig/selinux
  setenforce 0
}

service_iptables
echo "DONE Running Server Configs...";echo
