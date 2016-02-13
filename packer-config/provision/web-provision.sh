#!/bin/bash

sleep 30
sudo /usr/bin/wget -O /tmp/puppetlabs-release-trusty.deb http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i /tmp/puppetlabs-release-trusty.deb
sudo apt-get update -y
sudo apt-get install puppet git-core -y
sudo mv /etc/puppet /etc/puppet.orig
sudo mkdir /etc/puppet
cd /etc/puppet
sudo git init /etc/puppet
sudo git remote add -f origin https://github.com/devopper/basic_stack.git
sudo git config core.sparseCheckout true
sudo mkdir /etc/puppet/.git/info/
sudo echo "puppet/" >> /etc/puppet/.git/info/sparse-checkout
sudo git pull origin master
