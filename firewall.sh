#!/bin/sh

echo "# Configure Firewall"
sudo apt install ufw

echo "# SSH"
sudo ufw allow in on lan from 192.168.0.0/16 to any port 22 proto tcp

sudo ufw allow from 192.168.0.0/16 to any port 5353 proto udp # avahi
sudo ufw allow from 192.168.0.0/16 to 224.0.0.251 proto igmp # mDNS
sudo ufw allow from 192.168.0.1 to 224.0.0.1 proto igmp # mDNS
sudo ufw allow from 192.168.0.1 to 224.0.0.1 port 5350 proto udp # PCP
sudo ufw allow from 192.168.0.1 to 224.0.0.1 port 5351 proto udp # PCP

echo "# PiHole dns, www, dhcp"
sudo ufw allow in on lan from 192.168.0.0/16 to any port 53
sudo ufw allow in on lan from 192.168.0.0/16 to any port 80 proto tcp
sudo ufw allow in on lan from any port 68 to any port 67 proto udp
echo ""

echo "# Samba"
sudo ufw allow in on lan from 192.168.0.0/16 to any port 139 proto tcp
sudo ufw allow in on lan from 192.168.0.0/16 to any port 445 proto tcp
echo ""

ufw allow from 192.168.0.0/24 to any port 5201 # iperf3

sudo ufw enable
echo ""
