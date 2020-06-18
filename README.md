# portscan.sh
Its a script which has all the best available options to find open ports and there services.

## Options
```
1- Naabu + Nmap        : Speed Of naabu to Scan Ports and enumerate its services using nmap
2- Masscan + Nmap      : Speed Of Masscan to Scan Ports and enumerate its services using nmap
3- Shodanfy            : Use Shodan.io to gets target ports and services
4- Simple Nmap         : Simple Nmap Scan For Most Common Service Ports
```
## Installation
```
$ sudo chmod +x install.sh
$ ./install.sh
```

## Usage
```
 _______ _______ _______________________ _______ _______ _         _______
(  ____ (  ___  (  ____ \__   __(  ____ (  ____ (  ___  ( (    /| (  ____ |\     /|
| (    )| (   ) | (    )|  ) (  | (    \| (    \| (   ) |  \  ( | | (    \| )   ( |
| (____)| |   | | (____)|  | |  | (_____| |     | (___) |   \ | | | (_____| (___) |
|  _____| |   | |     __)  | |  (_____  | |     |  ___  | (\ \) | (_____  |  ___  |
| (     | |   | | (\ (     | |        ) | |     | (   ) | | \   |       ) | (   ) |
| )     | (___) | ) \ \__  | |  /\____) | (____/| )   ( | )  \  |_/\____) | )   ( |
|/      (_______|/   \__/  )_(  \_______(_______|/     \|/    )_(_\_______|/     \|

                             @KathanP19
Usage:
      -o   Use For Output Folder Name
      -n   Use Naabu + Nmap for Port Scanning
      -m   Use Massscan + Nmap for Port Scanning
      -s   Use Shodanfy for Port Scanning using Shodan.io
      -p   Use Simple Nmap for Port Scanning
```

***Note:
`Option -o is necessary to use for giving folder name for your scan`***

## Example 
`./portscan.sh -o Target -n subdomains.txt` - Where `Target` is Name of dir , `subdomains.txt` is the list of subdomains.

You can also use multiple options for example.
`./portscan.sh -o Target -n subdomains.txt -p subdomains.txt` But Dont Forget to put subdomains list again with the option.
