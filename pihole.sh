#!/bin/sh

echo "# Install Pi-hole - accept all default options"
# curl -sSL https://install.pi-hole.net | bash
wget -O pihole-install.sh https://install.pi-hole.net
sudo bash pihole-install.sh
echo ""

echo "# Configure server to use Pi-hole DNS server - fixes SERVFAIL errors for domains relying on DNS over TCP like debian.org"
NETWORKCONF="/etc/dhcpcd.conf"
sudo sed -i 's/static domain_name_servers=192.*/static domain_name_servers=127.0.0.1/' $NETWORKCONF
tail -n 6 $NETWORKCONF
sudo service dhcpcd restart
echo ""

echo "# Configure Firewall"
sudo ufw allow from 192.168.0.0/24 to any port 53 # dns
sudo ufw allow from 192.168.0.0/24 to any port 80 proto tcp # www
# sudo ufw deny from ::/0 to any port 80 proto tcp # www deny IPV6 to stop ufw logs
echo ""

echo "# Update Pi-hole"
sudo pihole -up
sudo pihole -g
echo ""

echo "# Set Password"
sudo pihole -a -p
echo ""

echo "# Install Unbound"
sudo apt install unbound -y
echo ""

echo "# Configure DnsMasq for Unbound"
DNSMASQCONF="/etc/dnsmasq.d/99-edns.conf"
echo 'edns-packet-max=1232' | sudo tee -a $DNSMASQCONF > /dev/null
tail -n 8 $DNSMASQCONF
sudo pihole restartdns
echo ""

echo "# Configure Unbound"
echo "~~~"
echo "https://docs.pi-hole.net/guides/dns/unbound/"
echo "~~~"
echo "sudo nano /etc/unbound/unbound.conf.d/pi-hole.conf"
echo "~~~"
echo "sudo service unbound restart"
echo "~~~"
echo ""

echo "# Configure Pi-hole"
echo "~~~"
echo "http://192.168.0.200/admin"
echo "~~~"
echo "Settings > DNS > Upstream DNS Servers > Custom 1 = 127.0.0.1#5335"
echo "~~~"
echo ""

echo "# Configure Clients"
echo "~~~"
echo "Router > Advanced > Network > DHCP Server > Primary DNS = 191.168.0.200"
echo "Manually configure clients to use manual DNS server"
echo "~~~"
echo ""
