# Raspberry Pi Home Server Installation / Configuration Scripts

Notes for installing new OS:
* Activate router DHCP and DNS so it's available on the network for setup
* Copy these instructions to PC hard drive as the NAS will not be available
* Copy docker .env file actual passwords/keys
* Copy postfix password

## Operating System
[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit) (64-bit trixie) 2025-12-04

## Install Preparation
* Open [Raspberry Pi Imager](https://www.raspberrypi.org/software/) on remote computer
* Click **Choose OS**, click **Raspberry Pi OS (other)**, click **Raspberry Pi OS Lite (64 bit)**
* Choose hostname = rpi4b
* Capital City = Washington, DC
* Timezone = America/Boise - doesn't seem to work
* Keyboard layout = us
* Username = john
* Enable SSH = ON
* Power on Raspberry Pi
* SSH into Raspberry Pi using IP address and john user

**if ssh server doesn't start on first boot then put empty file ssh in boot (fat) partition (same directory as start.elf)**

https://www.raspberrypi.com/news/cloud-init-on-raspberry-pi-os/

## Clone this repository
~~~
sudo apt install git
mkdir install
cd install
git clone https://github.com/johnlevandowski/Raspberry-Pi-Server.git .
~~~

## Installation / Configuration

* Set Timezone - should be done by RPI Imager but doesn't seem to work
~~~
sudo raspi-config nonint do_change_timezone "America/Boise"
timedatectl
~~~

* Configure Locale - raspberry pi OS defaults to en_GB
~~~
sudo raspi-config nonint do_change_locale "en_US.UTF-8 UTF-8"
locale
~~~

* Set fixed IP address
~~~
sudo nmcli c show
sudo nmcli c mod "netplan-eth0" ipv4.addresses 192.168.0.2/24 ipv4.method manual
sudo nmcli c mod "netplan-eth0" ipv4.gateway 192.168.0.1
sudo nmcli c mod "netplan-eth0" ipv4.dns "1.0.0.1 9.9.9.9" # use cloudflare and quad9 as centurylink fails on debian.org when using pihole/unbound
sudo nmcli c mod "netplan-eth0" ipv4.dns-options "timeout:2" # 2 second timeout to try next dns server
sudo nmcli c down "netplan-eth0" && sudo nmcli c up "netplan-eth0"
~~~

* Set hostname in /etc/hosts  
~~~
sudo nano /etc/hosts
~~~

~~~
127.0.1.1       rpi5.lan.johnl.dev rpi5
~~~

* Login with new IP Address

* Update Pi OS
~~~
sudo apt update
sudo apt full-upgrade -y
sudo apt install dnsutils -y
~~~

* Raspberry PI boot options
~~~
BOOTCONF="/boot/firmware/config.txt"
echo '' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtparam=sd_poll_once' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-wifi' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-bt' | sudo tee -a $BOOTCONF > /dev/null
tail -n 4 $BOOTCONF
~~~

* Change journald to persistent - rasperry pi OS now has systemd journald set to volatile by default
~~~
sudo nano /usr/lib/systemd/journald.conf.d/40-rpi-volatile-storage.conf
Storage=persistent
sudo systemctl restart systemd-journald
~~~

* Reduce journald Journal Size
~~~
JOURNALCONF="/etc/systemd/journald.conf.d/rpi.conf"
sudo install -Dv /dev/null $JOURNALCONF
echo '[Journal]' | sudo tee -a $JOURNALCONF > /dev/null
echo 'SystemMaxUse=1000M' | sudo tee -a $JOURNALCONF > /dev/null
sudo systemctl restart systemd-journald
~~~

* Mount /tmp on tmpfs - seems to be default in debian 13
~~~
FSTAB="/etc/fstab"
echo '' | sudo tee -a $FSTAB > /dev/null
echo 'tmpfs /tmp tmpfs defaults,noatime,nosuid,nodev,noexec 0 0' | sudo tee -a $FSTAB > /dev/null
tail -n 6 $FSTAB
sudo rm -rfv /tmp
~~~

* Raspberry Pi bootloader EEPROM
~~~
sudo rpi-eeprom-update
~~~

* Reboot, then update EEPROM as needed using sudo rpi-eeprom-update -a and then reboot after updating

[Enable TRIM support](https://www.jeffgeerling.com/blog/2020/enabling-trim-on-external-ssd-on-raspberry-pi) - not supported on sandisk extreme pro usb SSD flash drive
