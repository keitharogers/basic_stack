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
sudo /etc/init.d/jenkins start
sleep 30
sudo /etc/init.d/jenkins stop
sudo [[ -d /var/lib/jenkins/plugins/ ]] mkdir -p /var/lib/jenkins/plugins/
sudo [[ -d /var/lib/jenkins/.ssh/ ]] mkdir -p /var/lib/jenkins/.ssh/
sudo wget -O /var/lib/jenkins/plugins/golang.hpi https://updates.jenkins-ci.org/latest/golang.hpi
sudo wget -O /var/lib/jenkins/plugins/git.hpi https://updates.jenkins-ci.org/latest/git.hpi
sudo wget -O /var/lib/jenkins/plugins/git-client.hpi https://updates.jenkins-ci.org/latest/git-client.hpi
sudo wget -O /var/lib/jenkins/plugins/scm-api.hpi https://updates.jenkins-ci.org/latest/scm-api.hpi
sudo wget -O /var/lib/jenkins/plugins/publish-over-ssh.hpi https://updates.jenkins-ci.org/latest/publish-over-ssh.hpi
sudo git init /var/lib
cd /var/lib
sudo git remote add -f origin https://github.com/devopper/basic_stack.git
sudo git config core.sparseCheckout true
sudo touch /var/lib/.git/info/sparse-checkout
sudo mv /var/lib/jenkins/jobs /var/lib/jenkins/jobs.orig
sudo mv /var/lib/jenkins/.ssh /var/lib/jenkins/.ssh.old
echo -e "jenkins-config/jobs/*" | sudo tee /var/lib/.git/info/sparse-checkout
echo -e "jenkins-config/.ssh/*" | sudo tee -a /var/lib/.git/info/sparse-checkout
sudo git pull origin master
