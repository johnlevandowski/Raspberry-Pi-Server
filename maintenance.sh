#!/bin/sh

echo "# Update Pi OS"
sudo apt update
sudo apt upgrade
echo ""

echo "# Update Rclone"
sudo rclone selfupdate
echo ""

echo "# Raspberry Pi bootloader EEPROM"
sudo rpi-eeprom-update
echo ""
echo "# Reboot before updating EEPROM using sudo rpi-eeprom-update -a and then reboot after updating"
echo ""

echo "# temperature hopefully below 50C, if not check fan is working"
sudo vcgencmd measure_temp
echo ""
