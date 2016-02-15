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
sudo mv /var/lib/jenkins/hudson.maven.MavenModuleSet.xml /var/lib/jenkins/hudson.maven.MavenModuleSet.xml.orig
sudo mv /var/lib/jenkins/hudson.model.UpdateCenter.xml /var/lib/jenkins/hudson.model.UpdateCenter.xml.orig
sudo mv /var/lib/jenkins/hudson.plugins.git.GitSCM.xml /var/lib/jenkins/hudson.plugins.git.GitSCM.xml.orig
sudo mv /var/lib/jenkins/hudson.plugins.git.GitTool.xml /var/lib/jenkins/hudson.plugins.git.GitTool.xml.orig
sudo mv /var/lib/jenkins/hudson.scm.CVSSCM.xml /var/lib/jenkins/hudson.scm.CVSSCM.xml.orig
sudo mv /var/lib/jenkins/hudson.scm.SubversionSCM.xml /var/lib/jenkins/hudson.scm.SubversionSCM.xml.orig
sudo mv /var/lib/jenkins/hudson.tasks.Ant.xml /var/lib/jenkins/hudson.tasks.Ant.xml.orig
sudo mv /var/lib/jenkins/hudson.tasks.Mailer.xml /var/lib/jenkins/hudson.tasks.Mailer.xml.orig
sudo mv /var/lib/jenkins/hudson.tasks.Maven.xml /var/lib/jenkins/hudson.tasks.Maven.xml.orig
sudo mv /var/lib/jenkins/hudson.tasks.Shell.xml /var/lib/jenkins/hudson.tasks.Shell.xml.orig
sudo mv /var/lib/jenkins/hudson.triggers.SCMTrigger.xml /var/lib/jenkins/hudson.triggers.SCMTrigger.xml.orig
sudo mv /var/lib/jenkins/jenkins.model.ArtifactManagerConfiguration.xml /var/lib/jenkins/jenkins.model.ArtifactManagerConfiguration.xml.orig
sudo mv /var/lib/jenkins/jenkins.model.DownloadSettings.xml /var/lib/jenkins/jenkins.model.DownloadSettings.xml.orig
sudo mv /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml.orig
sudo mv /var/lib/jenkins/jenkins.mvn.GlobalMavenConfig.xml /var/lib/jenkins/jenkins.mvn.GlobalMavenConfig.xml.orig
sudo mv /var/lib/jenkins/jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin.xml /var/lib/jenkins/jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin.xml.orig
sudo mv /var/lib/jenkins/jenkins.security.QueueItemAuthenticatorConfiguration.xml /var/lib/jenkins/jenkins.security.QueueItemAuthenticatorConfiguration.xml.orig
sudo mv /var/lib/jenkins/org.jenkinsci.plugins.gitclient.JGitTool.xml /var/lib/jenkins/org.jenkinsci.plugins.gitclient.JGitTool.xml.orig
sudo mv /var/lib/jenkins/org.jenkinsci.plugins.golang.GolangBuildWrapper.xml /var/lib/jenkins/org.jenkinsci.plugins.golang.GolangBuildWrapper.xml.orig
echo -e "jenkins/*" | sudo tee /var/lib/.git/info/sparse-checkout
echo -e "jenkins/.ssh/*" | sudo tee -a /var/lib/.git/info/sparse-checkout
sudo git pull origin master
sudo chown -R jenkins:jenkins /var/lib/jenkins/
