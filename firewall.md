# Firewall

## Install
~~~
sudo apt install net-tools ufw
sudo netstat -tunpl
~~~

## SSH
~~~
sudo ufw allow 22/tcp comment "SSH"
~~~

## Enable UFW
~~~
sudo ufw enable
sudo ufw status verbose
~~~

## View UFW logs
~~~
sudo journalctl -k -r -g "UFW"
sudo journalctl -k -r --no-pager -n 10 -g "UFW" 
~~~

## PiHole
~~~
sudo ufw allow 53 comment "DNS"
sudo ufw allow to 0.0.0.0/0 port 67 proto udp comment "DHCP"
sudo ufw allow from 172.21.21.2 to 172.17.0.1 port 8080 proto tcp comment "Caddy proxy to pihole webserver"
~~~

## Caddy
~~~
sudo ufw allow 80/tcp comment "HTTP"
sudo ufw allow 443 comment "HTTPS"
~~~

## Samba
~~~
# sudo ufw allow 139/tcp comment "samba netbios"
sudo ufw allow 445/tcp comment "samba"
~~~

## Uptime Kuma
~~~
sudo ufw allow from 172.21.21.3 to 172.17.0.1 port 25 proto tcp comment "uptime kuma to postfix"
~~~

## iperf3
~~~
sudo ufw allow 5201 comment "iperf3"
~~~

## Change logging from low to off after testing
~~~
sudo ufw logging off
~~~

## Other rules not needed after changing logging to off

### Disable mDNS so it isn't in logs
~~~
sudo ufw deny to 224.0.0.1 proto igmp comment "mDNS"
sudo ufw deny 5353/udp comment "mDNS"
~~~

### Block traffic from 1.1.1.2
When connected to tailscale  
My calix router sends traffic for 1.1.1.2 to a quantenna (wifi chip calix uses) login page  
Similar to how 1.1.1.1 goes to calix router login page  
Tailscale must send traffic to 1.1.1.2 when connected  
Seems to only occur when tailscale machine is being used (ie, as DNS server or browsing to web server)  
~~~
sudo ufw deny from 1.1.1.2
~~~
