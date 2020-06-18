#!/bin/bash

echo -e "\n\e[31m Please Enter You Sudo Password For installation\e[0m";
read PASS
echo "export PASS=$PASS" >> ~/.bash_profile
source ~/.bash_profile

#Install cf-check
echo -e "\n===============Installing CF-CHECK=================="
go get -u github.com/dwisiswant0/cf-check
echo -e "\n==================Done==================" 

#Install naabu
echo -e "\n===============Installing NAABU=================="
GO111MODULE=on go get -v github.com/projectdiscovery/naabu/cmd/naabu
echo -e "\n==================Done==================" 

#Install Masscan
echo -e "\n===============Installing Masscan=================="
echo $PASS | sudo -S apt-get install git gcc make libpcap-dev
git clone https://github.com/robertdavidgraham/masscan
cd masscan
make
cd ..
rm -rf masscan
echo -e "\n==================Done==================" 

#Install Filter-Resolved
echo -e "\n===============Installing Filter-resolved=================="
go get github.com/tomnomnom/hacks/filter-resolved
echo -e "\n==================Done==================" 

#Give Execution permission
echo $PASS | sudo -S chmod +x portscan.sh
echo $PASS | sudo -S chmod +x ./tools/naabu2nmap.sh
echo $PASS | sudo -S chmod +x ./tools/massnmap.sh
