#!/bin/bash

sleep 30
sudo wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install openjdk-7-jre openjdk-7-jdk git -y
sudo apt-get install jenkins -y
sudo sed -i '/exit 0/d' /etc/rc.local
echo -e "iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080" | sudo tee -a /etc/rc.local
echo -e "iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 8080" | sudo tee -a /etc/rc.local
echo -e "exit 0" | sudo tee -a /etc/rc.local
sudo wget -O /var/lib/jenkins/plugins/golang.hpi https://updates.jenkins-ci.org/latest/golang.hpi
sudo wget -O /var/lib/jenkins/plugins/git.hpi https://updates.jenkins-ci.org/latest/git.hpi
sudo wget -O /var/lib/jenkins/plugins/envinject.hpi https://updates.jenkins-ci.org/latest/envinject.hpi
