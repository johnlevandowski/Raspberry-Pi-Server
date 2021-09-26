#!/bin/sh

echo "# Update Pi OS"
sudo apt update
sudo apt upgrade
echo ""

echo "# Update Pi-hole"
sudo pihole -up
sudo pihole -g
echo ""

echo "# Update Rclone"
curl https://rclone.org/install.sh | sudo bash
echo ""

echo "# Raspberry Pi bootloader EEPROM"
sudo rpi-eeprom-update
echo ""
echo "# Reboot before updating EEPROM using sudo rpi-eeprom-update -a and then reboot after updating"
echo ""
