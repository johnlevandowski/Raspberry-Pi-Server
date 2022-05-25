#!/bin/sh

# Dynamic DNS
sudo apt install ddclient libio-socket-ssl-perl # just enter through all the options
# sudo nano /etc/ddclient.conf
# use=web # get current IP from web
# ssl=yes
# protocol=googledomains
# login=generated_username
# password=generated_password
# sub.johnlevandowski.com
# sudo nano /etc/default/ddclient
# run_daemon="true"
sudo systemctl start ddclient
