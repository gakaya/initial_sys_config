#!/bin/bash

# remove old ruby
yum erase ruby -y

# install dependencies
yum install libyaml-devel readline-devel libffi-devel libtool bison sqlite-devel -y

# install rvm
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
\curl -sSL https://get.rvm.io | bash -s stable

# install ruby 2.x
RUBY_VERSION="2.2.0"
/usr/local/rvm/bin/rvm install ruby-$VERSION 
/usr/local/rvm/bin/rvm --default use ruby-$VERSION
/usr/local/rvm/bin/rvm list rubies
