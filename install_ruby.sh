#!/usr/bin/env bash

echo 
echo "#####################################"
echo "SCRIPT: $0"
echo "Installing RUBY Packages..."
echo "#####################################"
echo

echo "Installing RUBY..."
yum install ruby ruby-devel ruby-irb ruby-libs ruby-ri rubygems rubygems-devel rubygem-rake  -y > /dev/null

echo; echo "DONE Installing RUBY Packages..."; echo
