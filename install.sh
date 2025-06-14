#!/bin/sh

# When installing new OS
# Activate router DHCP and DNS so it's available on the network for setup
# Copy installation setup instructions to PC hard drive as the NAS will not be available
# Copy .env file actual passwords/keys

# Raspberry PI Imager Settings
# OS = Raspberry PI OS Lite (64-bit)
# Hostname = rpi4b.home.johnlevandowski.com
# Username/Password = John
# Locale = 
# Timezone = 
# Enable SSH

echo "# Set Timezone - should be done by RPI Imager"
sudo timedatectl set-timezone US/Mountain
echo ""

echo "# Set Keyboard Layout - should be done by RPI Imager"
sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"us\"/g' /etc/default/keyboard
echo ""

echo "# Configure Locale - should be done by RPI Imager"
sudo sed -i 's/en_GB.UTF-8 UTF-8/# en_GB.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
sudo update-locale LANG=en_US.UTF-8
echo ""

echo "# Mount /tmp on tmpfs"
FSTAB="/etc/fstab"
echo '' | sudo tee -a $FSTAB > /dev/null
echo 'tmpfs /tmp tmpfs defaults,noatime,nosuid,nodev,noexec 0 0' | sudo tee -a $FSTAB > /dev/null
tail -n 6 $FSTAB
sudo rm -rfv /tmp
echo ""

echo "# Reduce systemd Journal Size"
sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=100M/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald
echo ""

echo "# Reboot and Login and run install2.sh"
