#!/bin/bash

sleep 30
sudo yum -y install golang
sed -i '/export PATH/s//export GOPATH=\$HOME\/go/' ~/.bash_profile
echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.bash_profile
echo "export GOBIN=\$HOME/go/bin" >> ~/.bash_profile
