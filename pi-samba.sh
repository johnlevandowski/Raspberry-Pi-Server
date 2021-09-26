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
echo "add to bottom of configuration"
echo "~~~"
echo "[share]"
echo "	path = /share"
echo "	read only = no"
echo "	public = no"
echo "	writeable = yes"
echo "	create mask = 0777"
echo "	force create mode = 0777"
echo "	directory mask = 0777"
echo "	force directory mode = 0777"
echo "~~~"
echo "sudo systemctl restart smbd"
echo "~~~"
echo ""
