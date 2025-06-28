# Enable unbound-control
docker exec -it unbound unbound-control-setup  
then enable in unbound.conf at bottom of file  

# Validate dnssec is working
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

# Apple devices publish device dhcp hostname
Wi-fi Network > Private Wi-Fi Address = OFF

# PiHole Lists
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/ultimate.txt  
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt  
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/fake.txt  
PiHole > Tools > Update Gravity  

# Tailscale
~~~
curl -fsSL https://tailscale.com/install.sh > tailscale.sh
sh tailscale.sh
sudo tailscale up --accept-dns=false
~~~
PiHole > Settings > DNS > Interface Settings = Permit all origins  
PiHole > Settings > DNS > Advanced DNS Settings > Never forward non-FQDN A and AAAA queries = ON  
PiHole > Settings > DNS > Conditional Forwarding = true,100.64.0.0/10,100.100.100.100  
