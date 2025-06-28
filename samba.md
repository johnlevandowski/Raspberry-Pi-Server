# Samba Install

## Install Samba - wins = no
~~~
sudo apt install samba -y
sudo smbpasswd -a john
~~~

## Set up share directory
~~~
sudo mkdir /share
sudo chown -R 1000:1000 /share
~~~

## Configure Samba
~~~
SAMBACONF="/etc/samba/smb.conf"
echo '' | sudo tee -a $SAMBACONF > /dev/null
echo '[share]' | sudo tee -a $SAMBACONF > /dev/null
echo '	path = /share' | sudo tee -a $SAMBACONF > /dev/null
echo '	available = yes' | sudo tee -a $SAMBACONF > /dev/null
echo '	browseable = yes' | sudo tee -a $SAMBACONF > /dev/null
echo '	writeable = yes' | sudo tee -a $SAMBACONF > /dev/null
echo '	read only = no' | sudo tee -a $SAMBACONF > /dev/null
echo '	force user = john' | sudo tee -a $SAMBACONF > /dev/null
echo '	public = no' | sudo tee -a $SAMBACONF > /dev/null
echo '	guest ok = no' | sudo tee -a $SAMBACONF > /dev/null
~~~

## Restart Samba
~~~
sudo systemctl restart smbd
~~~

## old samba Config below
~~~
echo '	create mask = 0777' | sudo tee -a $SAMBACONF > /dev/null
echo '	force create mode = 0777' | sudo tee -a $SAMBACONF > /dev/null
echo '	directory mask = 0777' | sudo tee -a $SAMBACONF > /dev/null
echo '	force directory mode = 0777' | sudo tee -a $SAMBACONF > /dev/null
~~~

~~~
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
~~~
