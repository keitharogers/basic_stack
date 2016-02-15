# Jenkins Configuration

I have tried to automate the provision of Jenkins as much as possible. In order to achieve this, I have included the SSH keys, build job, and various configuration files which are checked out from Git during the build of the AMI by Packer. The only thing I chose to exclude are user credentials and as such the only manual step for this is to add users manually to secure the application.
