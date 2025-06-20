# Enable unbound-control
docker exec -it unbound bash
unbound-control-setup
then enable in unbound.conf at bottom of file

# Validate dnssec is working
dig fail01.dnssec.works @127.0.0.1 -p 5335
dig dnssec.works @127.0.0.1 -p 5335

dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335
dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335

dig sigfail.ippacket.stream @127.0.0.1 -p 5335
dig sigok.ippacket.stream @127.0.0.1 -p 5335

Apple devices publish device name
Private Wi-Fi Address = OFF
