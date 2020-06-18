# Shodanfy.py 

```diff 
- Don't use this tool because your ip will be blocked by Shodan!
``` 


Get ports,vulnerabilities,informations,banners,..etc for any IP with Shodan (no apikey! no rate limit!)


![main](https://i.imgur.com/TgTEYfL.png)


# Usage

``` **** USAGE **** 
# python3 shodanfy.py <ip> [OPTIONS] 
e.g:
    python3 shodanfy.py 111.111.111.111 
    python3 shodanfy.py 111.111.111.111 --getports
    python3 shodanfy.py 111.111.111.111 --getvuln
    python3 shodanfy.py 111.111.111.111 --getinfo
    python3 shodanfy.py 111.111.111.111 --getmoreinfo
    python3 shodanfy.py 111.111.111.111 --getbanner
    python3 shodanfy.py 111.111.111.111 --getports --getvuln
    python3 shodanfy.py 111.111.111.111 --proxy 127.0.0.1:8080
# support pipeline, --stdin option is required..
# echo "<ip>" or cat ips.txt | python3 shodanfy.py --stdin [OPTIONS]
e.g:
    echo "111.111.111.111"|python3 shodanfy.py --stdin 
    echo "111.111.111.111"|python3 shodanfy.py --stdin --proxy 127.0.0.1:8080
    echo "111.111.111.111"|python3 shodanfy.py --stdin --getvuln 
    cat ips.txt|python3 shodanfy.py --stdin --getports
    dig google.com +short A | grep -oi '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | python3 shodanfy.py --stdin --geports
```
