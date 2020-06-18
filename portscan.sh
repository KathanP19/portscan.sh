#!/bin/bash

#Functions

#Make Directories

logo(){
echo -e "\e[96m _______ _______ _______________________ _______ _______ _         _______         ";
echo -e "\e[96m(  ____ (  ___  (  ____ \__   __(  ____ (  ____ (  ___  ( (    /| (  ____ |\     /|";
echo -e "\e[96m| (    )| (   ) | (    )|  ) (  | (    \| (    \| (   ) |  \  ( | | (    \| )   ( |";
echo -e "\e[96m| (____)| |   | | (____)|  | |  | (_____| |     | (___) |   \ | | | (_____| (___) |";
echo -e "\e[96m|  _____| |   | |     __)  | |  (_____  | |     |  ___  | (\ \) | (_____  |  ___  |";
echo -e "\e[96m| (     | |   | | (\ (     | |        ) | |     | (   ) | | \   |       ) | (   ) |";
echo -e "\e[96m| )     | (___) | ) \ \__  | |  /\____) | (____/| )   ( | )  \  |_/\____) | )   ( |";
echo -e "\e[96m|/      (_______|/   \__/  )_(  \_______(_______|/     \|/    )_(_\_______|/     \|";
echo -e "\e[96m                                                                                   \e[0m";
echo -e "\e[96m                             @KathanP19                                                      \e[0m";
}
logo

folder(){
mkdir -p results
mkdir -p results/$dir
mkdir -p results/$dir/scan_results
}

naabu_scan(){
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m USING NAABU2NMAP TO SCAN SUBDOMAINS\e[0m\n";
cat $target | echo $PASS | sudo -S ~/go/bin/naabu -ports top-1000 -silent | bash ./tools/naabu2nmap.sh | tee ./results/$dir/scan_results/raw_scan.txt
mv naabu_output_ports.txt ./results/$dir/
mv naabu_output_targets.txt ./results/$dir/
echo -e "\nPORT SCANNING COMPLETED \e[32mFINISH\e[0m";
}

mass_scan(){
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m USING MASSNMAP TO SCAN SUBDOMAINS\e[0m\n";
cat $target | while read subs; do echo $PASS | sudo -S ./tools/massnmap.sh $subs ;done
sudo mv massnmap/ ./results/$dir/
rmdir ./results/$dir/scan_results
echo -e "\nPORT SCANNING COMPLETED \e[32mFINISH\e[0m";
}

shodanfy_scan(){
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m USING Shodanfy.py FOR PORT-SCAN\e[0m\n";
cat $target | filter-resolved | cf-check > ./results/$dir/ip_to_scan.txt
cat ./results/$dir/ip_to_scan.txt | python3 ./tools/Shodanfy.py/shodanfy.py --stdin --getvuln --getinfo --getports | tee ./results/$dir/port_scan_results.txt
rmdir ./results/$dir/scan_results
echo -e "\nPORT SCANNING COMPLETED \e[32mFINISH\e[0m";
}

simple_nmap(){
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m USING NMAP TO SCAN SUBDOMAINS\e[0m\n";
nmap -sV -T3 -Pn -p2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,443,7447,7080,8880,8983,5673,7443,19000,19080,9200 -iL $target | tee ./results/$dir/nmap_raw_scan.txt
rmdir ./results/$dir/scan_results
echo -e "\nPORT SCANNING COMPLETED \e[32mFINISH\e[0m";
}

while getopts ":n:o:m:s:p:" opt;do
        case ${opt} in
                n ) target=$OPTARG
                    naabu_scan $target
                    ;;
                o ) dir=$OPTARG
                    folder $dir
                    ;;
		m ) target=$OPTARG
                    mass_scan $target
                    ;;
		s ) target=$OPTARG
                    shodanfy_scan $target
                    ;;
		p ) target=$OPTARG
                    simple_nmap $target
                    ;;
                \? ) echo "Usage:"
		     echo "      -o   Use For Output Folder Name";
                     echo "      -n   Use Naabu + Nmap for Port Scanning";
		     echo "      -m   Use Massscan + Nmap for Port Scanning";
		     echo "      -s   Use Shodanfy for Port Scanning using Shodan.io";
		     echo "      -p   Use Simple Nmap for Port Scanning";
                     ;;
                : ) echo "Invalid Option $OPTARG require an argument"
                    ;;
        esac
done
shift $((OPTIND -1))
