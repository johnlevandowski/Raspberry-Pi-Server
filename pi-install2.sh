#!/bin/sh

echo "# Enable SSH"
sudo systemctl enable ssh
echo ""

echo "# Update Pi OS"
sudo apt update
sudo apt full-upgrade -y
echo ""

echo "# Configure Static IP Address"
echo "~~~"
echo "sudo nano /etc/dhcpcd.conf"
echo "~~~"
echo "interface eth0"
echo "static ip_address=192.168.0.10/24"
echo "static routers=192.168.0.1"
echo "static domain_name_servers=192.168.0.1"
echo "~~~"
echo ""

echo "# Add User"
echo "~~~"
echo "sudo adduser john"
echo "sudo adduser john sudo"
echo "~~~"
echo ""

echo "# Reboot and Login with new user and run pi-install3.sh"
echo ""
