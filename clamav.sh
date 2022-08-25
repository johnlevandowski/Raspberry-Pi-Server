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

sudo clamdscan --fdpass --move=/root/quarantine /

# add cron entry to cron.d
# freshclam updates at 3am daily
# about 21 GB is 91 minutes total run time
echo "0 5 * * 0 root clamdscan --fdpass --move=/root/quarantine /" | sudo tee /etc/cron.d/clamdscan
