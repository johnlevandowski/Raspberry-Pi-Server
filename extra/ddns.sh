#!/bin/sh

# Dynamic DNS
sudo apt install ddclient # just enter through all the options
# cloudflare token must be to edit all zones not specific zone
# cloudflare token only works with ddclient 3.10 and above
# sudo nano /etc/ddclient.conf

daemon=300
ssl=yes
use=web, web=https://api.ipify.org/

protocol=cloudflare \
login=token \
password='token' \
zone=johnlevandowski.com \
lan.johnlevandowski.com

test ip lookup
sudo ddclient -query

test ip update
sudo ddclient -daemon=0 -verbose -noquiet

# during testing you may need to delete ddclient cache
# sudo rm /var/cache/ddclient/ddclient.cache

# sudo nano /etc/default/ddclient
# run_daemon="true"
sudo systemctl start ddclient
