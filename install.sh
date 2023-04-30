#!/bin/sh

echo "# Set Timezone"
sudo timedatectl set-timezone US/Mountain
echo ""

echo "# Set Keyboard Layout"
sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"us\"/g' /etc/default/keyboard
echo ""

echo "# Configure Locale"
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
echo ""

echo "# Reboot and Login and run install2.sh"
