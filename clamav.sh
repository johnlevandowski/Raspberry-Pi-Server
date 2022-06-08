#!/bin/sh

echo "# Install ClamAV"
sudo apt update
sudo apt install clamav clamav-daemon
echo ""

sudo mkdir /root/quarantine

sudo nano /etc/clamav/clamd.conf

ExcludePath ^/dev
ExcludePath ^/proc
ExcludePath ^/run
ExcludePath ^/sys
ExcludePath ^/root/quarantine
ExcludePath ^/var/lib/samba/private/msg.sock
ExcludePath ^/var/spool/postfix/dev
ExcludePath ^/var/spool/postfix/private
ExcludePath ^/var/spool/postfix/public

Takes 18 minutes excluding /share directory

sudo clamdscan --fdpass --move=/root/quarantine /

# add cron entry to cron.d
echo "0 3 * * 0 root clamdscan --fdpass --move=/root/quarantine /" | sudo tee /etc/cron.d/clamdscan
