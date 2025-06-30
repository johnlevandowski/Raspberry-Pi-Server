# Raspberry Pi Home Server Installation / Configuration Scripts

Notes for installing new OS:
* Activate router DHCP and DNS so it's available on the network for setup
* Copy these instructions to PC hard drive as the NAS will not be available
* Copy docker .env file actual passwords/keys
* Copy postfix password

## Operating System
[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit) (64-bit bookworm) 2025-05-13

## Install Preparation
1. Open [Raspberry Pi Imager](https://www.raspberrypi.org/software/) on remote computer
2. Click **Choose OS**, click **Raspberry Pi OS (other)**, click **Raspberry Pi OS Lite (64 bit)**
3. Click Advanced Options
4. Check **Set hostname**
5. Update hostname = rpi4b
6. Set password for *john* user
7. Timezone = America/Denver - doesn't seem to work
8. Keyboard layout = us
9. Check **Enable SSH**
10. Click **Save**
11. Click **Choose Storage**, click Storage Device to use
12. Click **Write**
13. Insert/Attach Storage Device to Raspberry Pi
14. Power on Raspberry Pi
15. SSH into Raspberry Pi using IP address and *john* user

## Clone this repository
~~~
sudo apt install git
mkdir install
cd install
git clone https://github.com/johnlevandowski/Raspberry-Pi-Server.git .
~~~

## Installation / Configuration

1. Set Timezone - should be done by RPI Imager but doesn't seem to work
~~~
sudo raspi-config nonint do_change_timezone "America/Boise"
~~~

2. Configure Locale - raspberry pi OS defaults to en_GB
~~~
sudo raspi-config nonint do_change_locale "en_US.UTF-8 UTF-8"
~~~

3. Set fixed IP address
~~~
sudo nmcli c show
sudo nmcli c mod "Wired connection 1" ipv4.addresses 192.168.0.2/24 ipv4.method manual
sudo nmcli c mod "Wired connection 1" ipv4.gateway 192.168.0.1
sudo nmcli c mod "Wired connection 1" ipv4.dns 1.0.0.1 # use cloudflare as centurylink fails on debian.org when using pihole/unbound
sudo nmcli c down "Wired connection 1" && sudo nmcli c up "Wired connection 1"
~~~

4. Login with new IP Address

5. Update Pi OS
~~~
sudo apt update
sudo apt full-upgrade -y
sudo apt install dnsutils -y
~~~

6. Raspberry PI boot options
~~~
BOOTCONF="/boot/firmware/config.txt"
echo '' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtparam=sd_poll_once' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-wifi' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-bt' | sudo tee -a $BOOTCONF > /dev/null
tail -n 4 $BOOTCONF
~~~

7. Change journald to auto - rasperry pi OS now has systemd journald set to volatile by default
~~~
sudo sed -i 's/Storage=volatile/Storage=auto/' /etc/systemd/journald.conf
~~~

8. Reduce journald Journal Size
~~~
JOURNALCONF="/etc/systemd/journald.conf.d/rpi.conf"
sudo install -Dv /dev/null $JOURNALCONF
echo '[Journal]' | sudo tee -a $JOURNALCONF > /dev/null
echo 'SystemMaxUse=1000M' | sudo tee -a $JOURNALCONF > /dev/null
sudo systemctl restart systemd-journald
~~~

9. Mount /tmp on tmpfs
~~~
FSTAB="/etc/fstab"
echo '' | sudo tee -a $FSTAB > /dev/null
echo 'tmpfs /tmp tmpfs defaults,noatime,nosuid,nodev,noexec 0 0' | sudo tee -a $FSTAB > /dev/null
tail -n 6 $FSTAB
sudo rm -rfv /tmp
~~~

10. Raspberry Pi bootloader EEPROM
~~~
sudo rpi-eeprom-update
~~~

11. Reboot, then update EEPROM as needed using sudo rpi-eeprom-update -a and then reboot after updating

12. [Enable TRIM support](https://www.jeffgeerling.com/blog/2020/enabling-trim-on-external-ssd-on-raspberry-pi) - not supported on sandisk extreme pro usb SSD flash drive
