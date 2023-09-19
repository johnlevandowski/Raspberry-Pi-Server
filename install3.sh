#!/bin/sh

echo "# Lock pi user account"
sudo passwd -l pi
echo ""

echo "# Disable polling for SD-card, wifi, and bluetooth"
BOOTCONF="/boot/config.txt"
echo '' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtparam=sd_poll_once' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-wifi' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-bt' | sudo tee -a $BOOTCONF > /dev/null
tail -n 4 $BOOTCONF
echo ""

echo "# Raspberry Pi bootloader EEPROM"
sudo rpi-eeprom-update
echo ""
echo "# Reboot, then update EEPROM as needed using sudo rpi-eeprom-update -a and then reboot after updating"
echo ""
