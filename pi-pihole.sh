#!/bin/sh

echo "# Install Pi-hole"
curl -sSL https://install.pi-hole.net | bash # accept all default options
echo ""

echo "# Configure Firewall"
sudo ufw allow from 192.168.0.0/24 to any port 53 proto tcp # dns
sudo ufw allow from 192.168.0.0/24 to any port 53 proto udp # dns
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

echo "# Configure Unbound"
echo "~~~"
echo "sudo nano /etc/unbound/unbound.conf.d/pi-hole.conf"
echo "~~~"
echo "https://docs.pi-hole.net/guides/dns/unbound/"
echo "~~~"
echo "sudo service unbound restart"
echo "~~~"
echo ""

echo "# Configure Pi-hole"
echo "~~~"
echo "http://192.168.0.10/admin"
echo "~~~"
echo "Settings > DNS > Upstream DNS Servers > Custom 1 = 127.0.0.1#5335"
echo "~~~"
echo ""

echo "# Configure Clients"
echo "~~~"
echo "Router > Advanced > Network > DHCP Server > Primary DNS = 191.168.0.10"
echo "Manually configure clients to use manual DNS server"
echo "~~~"
echo ""
