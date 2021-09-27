#!/bin/sh

echo "# Lock pi user account"
sudo passwd -l pi
echo ""

echo "# Configure Firewall"
sudo apt install ufw
sudo ufw allow from 192.168.0.0/24 to any port 22 proto tcp # ssh
sudo ufw allow from 192.168.0.0/24 to any port 5353 proto udp # avahi
sudo ufw allow from 192.168.0.0/24 to 224.0.0.251 proto igmp # mDNS
sudo ufw allow from 192.168.0.1 to 224.0.0.1 proto igmp # mDNS
sudo ufw deny from ::/0 # deny IPv6
sudo ufw enable
echo ""

echo "# Disable polling for SD-card"
BOOTCONF="/boot/config.txt"
echo '' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtparam=sd_poll_once' | sudo tee -a $BOOTCONF > /dev/null
tail -n 3 $BOOTCONF
echo ""

echo "# Raspberry Pi bootloader EEPROM"
sudo rpi-eeprom-update
echo ""
echo "# Reboot, then update EEPROM as needed using sudo rpi-eeprom-update -a and then reboot after updating"
echo ""
