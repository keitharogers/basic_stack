#!/bin/bash

sleep 30
sudo -i
/usr/bin/wget -O /tmp/puppetlabs-release-trusty.deb http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i /tmp/puppetlabs-release-trusty.deb
apt-get update -y
apt-get install puppet git-core -y
mv /etc/puppet /etc/puppet.orig
cd /etc/puppet
git init /etc/puppet
git remote add -f origin https://github.com/devopper/basic_stack.git
git config core.sparseCheckout true
echo "puppet/" >> /etc/puppet/.git/info/sparse-checkout
git pull origin master
