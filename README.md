# Raspberry Pi Home Server Installation / Configuration Scripts

## Clone this repository
~~~
git clone http://pi.johnlevandowski.com
~~~

## Operating System
Raspberry Pi OS Lite 2021-05-07

## Install Preparation
1. Open [Raspberry Pi Imager](https://www.raspberrypi.org/software/) on remote computer
2. Click **Choose OS**, click **Raspberry Pi OS (other)**, click **Raspberry Pi OS Lite**
3. **Ctrl-Shift-x** to enter Advanced Options
4. Check **Set hostname**
5. Update hostname
6. Check **Enable SSH**
7. Set password for *pi* user
8. Click **Save**
9. Click **Choose Storage**, click Storage Device to use
10. Click **Write**
11. Insert/Attach Storage Device to Raspberry Pi
12. Power on Raspberry Pi
13. Open SSH application on remote computer
14. SSH into Raspberry Pi using IP address and *pi* user

## Installation / Configuration
1. sudo apt install git
2. git clone http://pi.johnlevandowski.com
3. ./pi.johnlevandowski.com/pi-install.sh to configure base OS settings
4. logout and login to update settings
5. ./pi.johnlevandowski.com/pi-install2.sh to update base OS
6. sudo reboot
7. SSH into Raspberry Pi using **new user** and **new static IP address**
8. sudo mv /home/pi/pi.johnlevandowski.com ~
9. sudo chown -R john:john pi.johnlevandowski.com
10. ./pi.johnlevandowski.com/pi-install3.sh to enable firewall
11. sudo reboot
12. run additional scripts to add individual server components

