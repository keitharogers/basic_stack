# Packer Configuration

The json files in this folder hold the information required to build a new AMI (Amazon Machine Image).

An example of this can be seen below and is taken from 'web-layer.json':

```json
{
  "variables": {
    "aws_access_key": "{{env `AWS_ACCESS_KEY`}}",
    "aws_secret_key": "{{env `AWS_SECRET_KEY`}}"
  },
  "builders": [{
    "type": "amazon-ebs",
    "communicator": "ssh",
    "ssh_pty": "true",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "eu-west-1",
    "source_ami": "ami-5a60c229",
    "instance_type": "t1.micro",
    "ssh_username": "ubuntu",
    "ami_name": "web-node {{timestamp}}"
  }],
  "provisioners": [{
    "type": "shell",
    "script": "provision/web-provision.sh"
    }
]
}
```

You'll note that under the provisioners section this includes a shell script for execution. This shell script includes all the custom commands we'll be using to provision our new AMI, an example of this can be seen below and is taken from 'provision/web-provision.sh':

```bash
#!/bin/bash

sleep 30
sudo /usr/bin/wget -O /tmp/puppetlabs-release-trusty.deb http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i /tmp/puppetlabs-release-trusty.deb
sudo apt-get update -y
sudo apt-get install puppet git-core -y
sudo mv /etc/puppet /etc/puppet.orig
sudo git init /etc
cd /etc
sudo git remote add -f origin https://github.com/devopper/basic_stack.git
sudo git config core.sparseCheckout true
sudo touch /etc/.git/info/sparse-checkout
echo -e "puppet/" | sudo tee /etc/.git/info/sparse-checkout
sudo git pull origin master
sudo puppet apply /etc/puppet/manifests/site.pp
```
