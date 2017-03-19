#!/usr/bin/env bash

echo 
echo "#####################################"
echo "SCRIPT: $0"
echo "Installing PERL Packages..."
echo "#####################################"
echo

echo "Installing Perl CPAN packages..."
yum install perl-CPAN perl-CPANPLUS -y > /dev/null

echo "Installing Perl MySQL packages..."
yum install perl-DBI perl-DBD-MySQL perl-DBD-Pg -y > /dev/null

echo; echo "DONE Installing PERL Packages..."; echo
