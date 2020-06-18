#!/bin/bash

#Escape slash from name for folder name
folderName=$(echo $1| awk '{gsub("/","_")}1');
mkdir -p ./massnmap/$folderName && cd ./massnmap/$folderName
fqdn=$1;
ipList=$(dig +short $fqdn|grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'); #Get all A names
if [ -z "$ipList" ]
then
	ipArgument=$fqdn
else
	ipArgument=$(echo $ipList| awk '{gsub(/ /,",")}1');
fi
masscan -p1-65535 $ipArgument --max-rate 1000 --open -oG "masscan_$folderName";
hostList=$(cat masscan_$folderName| grep open|cut -d" " -f2|sort -u);
for host in $hostList; do
	portList=$(cat masscan_$folderName| grep $host|grep -Po 'Ports: \K.*'|cut -d"/" -f1);
	portArgument=$(echo $portList| awk '{gsub(/ /,",")}1');
	nmap -p $portArgument -sV -Pn -oG "nmap_${host}_grepable" -oN "nmap_${host}_normal" $host;
	cat nmap_${host}_grepable | grep "Ports:" | cut -d"/" -f7 >> service.txt
done
