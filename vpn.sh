#!/bin/sh

echo "# Install PivVPN - Wireguard - public DNS name - unattended upgrades - reboot"
sudo curl -L https://install.pivpn.io | bash
echo ""

echo "# Add port forwarding to router"
echo ""

echo "# Add Wireguard User"
echo "# pivpn add"
echo "# pivpn -qr"


pihole dns changed to listen on all interfaces

sudo ufw allow from 10.6.0.2 to any port 53 proto udp # dns
sudo ufw allow from 10.6.0.2 to any port 80 proto tcp # www
sudo ufw allow from 10.6.0.2 to any port 139 proto tcp # samba
sudo ufw allow from 10.6.0.2 to any port 445 proto tcp # samba
