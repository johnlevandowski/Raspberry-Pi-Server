# Pi-hole

## Enable unbound-control
~~~
docker exec -it unbound unbound-control-setup  
~~~

~~~
nano ~/docker/pihole/etc-unbound/unbound.conf
~~~

~~~
control-enable: yes at bottom of config file  
~~~

## Validate dnssec is working
~~~
dig fail01.dnssec.works @localhost
dig dnssec.works @localhost
~~~

~~~
dig sigfail.verteiltesysteme.net @localhost
dig sigok.verteiltesysteme.net @localhost
~~~

~~~
dig sigfail.ippacket.stream @localhost
dig sigok.ippacket.stream @localhost
~~~

## Disable log servfail after testing
~~~
nano ~/docker/pihole/etc-unbound/unbound.conf
~~~

~~~
# log-servfail: yes
~~~

~~~
docker exec -it unbound unbound-control reload
~~~

## Apple devices publish device dhcp hostname
Wi-fi Network > Private Wi-Fi Address = OFF  

## PiHole Lists
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/ultimate.txt  
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt  
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/fake.txt  
PiHole > Tools > Update Gravity  

## PiHole configuration
Settings > Local DNS Records > Add as needed  
Settings > DHCP > DHCP server enabled = ON  

## Tailscale
~~~
curl -fsSL https://tailscale.com/install.sh > tailscale.sh
sh tailscale.sh
sudo tailscale up --accept-dns=false
~~~

PiHole > Settings > DNS > Interface Settings = Permit all origins  
PiHole > Settings > DNS > Conditional Forwarding = true,100.64.0.0/10,100.100.100.100  
