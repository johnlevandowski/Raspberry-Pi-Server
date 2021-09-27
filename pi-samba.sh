#!/bin/sh

echo "# Install Samba - wins = no"
sudo apt install samba samba-common-bin -y
echo ""

echo "# Install Rclone for cloud backup"
curl https://rclone.org/install.sh | sudo bash
echo ""

echo "# Configure Firewall"
sudo ufw allow from 192.168.0.0/24 to any port 139 proto tcp # samba
sudo ufw allow from 192.168.0.0/24 to any port 445 proto tcp # samba
echo ""

echo "# Add Samba User"
sudo smbpasswd -a john
echo ""

echo "# Create Share Folder"
sudo mkdir /share
sudo chmod 0777 /share
echo ""

echo "# Configure Samba"
SAMBACONF="/etc/samba/smb.conf"
echo '' | sudo tee -a $SAMBACONF > /dev/null
echo '[share]' | sudo tee -a $SAMBACONF > /dev/null
echo '	path = /share' | sudo tee -a $SAMBACONF > /dev/null
echo '	read only = no' | sudo tee -a $SAMBACONF > /dev/null
echo '	public = no' | sudo tee -a $SAMBACONF > /dev/null
echo '	writeable = yes' | sudo tee -a $SAMBACONF > /dev/null
echo '	create mask = 0777' | sudo tee -a $SAMBACONF > /dev/null
echo '	force create mode = 0777' | sudo tee -a $SAMBACONF > /dev/null
echo '	directory mask = 0777' | sudo tee -a $SAMBACONF > /dev/null
echo '	force directory mode = 0777' | sudo tee -a $SAMBACONF > /dev/null

echo "~~~"
echo "sudo nano /etc/samba/smb.conf"
echo "~~~"
echo "add to top of [global] section"
echo "~~~"
echo "vfs objects = catia fruit streams_xattr"
echo "fruit:model = RackMac"
echo "fruit:resource = xattr"
echo "fruit:nfs_aces = no"
echo "fruit:wipe_intentionally_left_blank_rfork = yes"
echo "fruit:delete_empty_adfiles = yes"
echo "~~~"
echo "sudo systemctl restart smbd"
echo "~~~"
echo ""
