#!/bin/bash

sleep 30
sudo yum -y install golang
sed -i '/export PATH/s//export GOPATH=\$HOME\/go/' ~/.bash_profile
echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.bash_profile
echo "export GOBIN=\$HOME/go/bin" >> ~/.bash_profile
mkdir -p /home/centos/go/bin
sudo mkdir -p ~/.ssh
sudo touch ~/.ssh/authorized_keys
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4YBRdlx3ChoWSCeUKP2XomzByLKvPBZsQmuYtG7Zhe23PPhywRhRmdINoDfNWQJ0dSZSiwF0XfFS7+v9xG8Yb9UzB9J64VfFZFPN1NS96uMirHkxBk3hmXKOpDCfSUWdLJc4VVn92T2/ZaXqHdXPol7xqrB1BlbyCYWKul1PcrY3XFg2TiWCz6bLpDAC9IQ2BXgzdee5piTXex2wCuC9HnbphzcihArbInHlMkMIPxQ5vbn/OmR7NoLFCPmhVHlmhzB+x6XT9Yn0K/rhFwUwMKDRmbaWxE1on7SMFNslVNo1qQ5p8VWphSWJJG/49StcEZ+I58WdNMvTYdlSwd1BL jenkins@ip-172-31-10-252" | sudo tee -a ~/.ssh/authorized_keys
