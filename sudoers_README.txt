Do these commands on the /etc/sudoers to only enable the wheel line with NOPASSWD.
The $1 is the matched group for (.*)

/bin/cp /etc/sudoers /etc/sudoers.ORIG

perl -pi -e 's/^%wheel/#wheel/' /etc/sudoers
perl -pi -e 's/^#\s%wheel(.*)/%wheel$1/' /etc/sudoers

Mon Mar 20 18:07:08 PDT 2017
root@server31: /var/tmp
hist:47  -> grep wheel /etc/sudoers
## Allows people in group wheel to run all commands
#wheel  ALL=(ALL)  ALL
%wheel  ALL=(ALL)  NOPASSWD: ALL
