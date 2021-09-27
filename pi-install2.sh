#!/bin/sh

echo "# Enable SSH"
sudo systemctl enable ssh
echo ""

echo "# Update Pi OS"
sudo apt update
sudo apt full-upgrade -y
echo ""

echo "# Configure Static IP Address"
NETWORKCONF="/etc/dhcpcd.conf"
echo '' | sudo tee -a $NETWORKCONF > /dev/null
echo 'interface eth0' | sudo tee -a $NETWORKCONF > /dev/null
echo 'static ip_address=192.168.0.10/24' | sudo tee -a $NETWORKCONF > /dev/null
echo 'static routers=192.168.0.1' | sudo tee -a $NETWORKCONF > /dev/null
echo 'static domain_name_servers=192.168.0.1' | sudo tee -a $NETWORKCONF > /dev/null
tail -n 6 $NETWORKCONF
echo ""

echo "# Add User"
sudo adduser john
sudo adduser john sudo
echo ""

echo "# Reboot and Login with new user and new IP address and run pi-install3.sh"
echo ""
