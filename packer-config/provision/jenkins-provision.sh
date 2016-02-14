#!/bin/bash

sleep 30
sudo wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install openjdk-7-jre openjdk-7-jdk -y
sudo apt-get install jenkins -y
sudo sh -c 'iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080' >> /etc/rc.local
sudo sh -c 'iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8080' >> /etc/rc.local

