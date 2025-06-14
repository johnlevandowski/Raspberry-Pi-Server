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

echo "Disable resolv.conf entry for unbound per https://docs.pi-hole.net/guides/dns/unbound/"
sudo systemctl disable --now unbound-resolvconf.service
sudo sed -Ei 's/^unbound_conf=/#unbound_conf=/' /etc/resolvconf.conf
sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf

echo "# Configure Unbound"
echo "~~~"
echo "https://docs.pi-hole.net/guides/dns/unbound/"
echo "~~~"
echo "sudo nano /etc/unbound/unbound.conf.d/pi-hole.conf"
echo "~~~"
echo "do-ip6 may be set to yes if you have IPv6 connectivity"
echo "~~~"

echo "sudo service unbound restart"
echo "~~~"
echo ""

echo "# Configure Pi-hole"
echo "~~~"
echo "http://192.168.0.200/admin"
echo "~~~"
echo "Settings > DNS > Upstream DNS Servers > Custom 1 = 127.0.0.1#5335"
echo "Settings > All Settings > Network Time Sync > ntp.ipv4.active = no"
echo "Settings > All Settings > Network Time Sync > ntp.ipv6.active = no"
echo "Settings > All Settings > Network Time Sync > ntp.sync.active = no"
echo "~~~"
echo ""

echo "# Configure Clients"
echo "~~~"
echo "Router > Advanced > Network > DHCP Server > Primary DNS = 191.168.0.200"
echo "Manually configure clients to use manual DNS server"
echo "Apple Devices - disable 'Limit IP Address Tracking' in the wifi settings"
echo "Apple Devices - or  BLOCK_ICLOUD_PR=false in /etc/pihole/pihole-FTL.conf "
echo "~~~"
echo ""
