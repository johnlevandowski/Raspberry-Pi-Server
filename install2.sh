#!/bin/sh

# Variables
FIXEDIP="192.168.0.200"

# ssh should already be enabled from raspberry pi imager install setting
# echo "# Enable SSH"
# sudo systemctl enable ssh
# echo ""

echo "# Update Pi OS"
sudo apt update
sudo apt full-upgrade -y
echo ""

sudo tee -a /etc/systemd/network/10-lan.link > /dev/null <<EOF
[Match]
MACAddress=12:34:56:78:90:23

[Link]
Name=lan
EOF

echo "# CHANGE TO HAVE STATIC IP ADDRESS CONFIGURED IN OPENWRT ROUTER VIA DHCP"
echo "# Configure Static IP Address"
NETWORKCONF="/etc/dhcpcd.conf"
echo '' | sudo tee -a $NETWORKCONF > /dev/null
echo 'interface lan' | sudo tee -a $NETWORKCONF > /dev/null
echo 'static ip_address='$FIXEDIP'/24' | sudo tee -a $NETWORKCONF > /dev/null
echo 'static routers=192.168.0.1' | sudo tee -a $NETWORKCONF > /dev/null
echo 'static domain_name_servers=192.168.0.1' | sudo tee -a $NETWORKCONF > /dev/null
tail -n 6 $NETWORKCONF
echo ""
echo "# set static ipv6 based on mac hardware address so it will never change on reinstall of os"
echo "# result should be DUID length of 36 characters
sed -i 's/slaac private/#slaac private/' $NETWORKCONF
sed -i 's/#slaac hwaddr/slaac hwaddr/' $NETWORKCONF
echo ""
sudo sed -i 's/127.0.1.1/'$FIXEDIP'/' /etc/hosts
cat /etc/hosts
echo ""

# should already be don from resapberry pi imager install setting
# echo "# Add User"
# sudo adduser john
# sudo adduser john sudo
# echo ""

echo "# Reboot and Login with new user and new IP address and run install3.sh"
echo ""
