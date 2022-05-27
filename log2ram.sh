#!/bin/sh

echo "# Install log2ram"
echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bullseye main" | sudo tee /etc/apt/sources.list.d/azlux.list
sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg
sudo apt update
sudo apt install log2ram rsync -y
echo ""

echo "# Mount /tmp on tmpfs"
FSTAB="/etc/fstab"
echo '' | sudo tee -a $FSTAB > /dev/null
echo 'tmpfs  /tmp  tmpfs  defaults,noatime,nosuid,nodev  0  0' | sudo tee -a $FSTAB > /dev/null
tail -n 6 $FSTAB
echo ""

echo "# Reduce systemd Journal Size"
sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=100M/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald
echo ""

echo "# Size of /var/log in megabytes"
sudo du -m /var/log
echo ""

echo "# Configure log2ram"
sudo sed -i 's/SIZE=40M/SIZE=200M/' /etc/log2ram.conf
echo ""

echo "# Reboot and Test"
echo "~~~"
echo "sudo reboot now"
echo "~~~"
echo "sudo systemctl status log2ram"
echo "~~~"
echo "df -h"
echo "~~~"
echo ""

# Find files written to disk in last day
# sudo find / -xdev -mtime -1 -print

# log2ram remove script
# https://github.com/azlux/log2ram/blob/master/uninstall.sh
