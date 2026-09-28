Raspberry Pi Home Server Installation / Configuration Scripts [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/johnlevandowski/Raspberry-Pi-Server)
===========================================================================================

Notes for installing new OS:
* Activate router DHCP and DNS so it's available on the network for setup
* View these instructions on GitHub as the NAS will not be available
* Copy docker .env file actual passwords/keys
* Copy postfix password


## Operating System

[Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit) (64-bit trixie) 2026-06-18


## Install Preparation

* Open [Raspberry Pi Imager](https://www.raspberrypi.org/software/) on remote computer
* OS > Raspberry Pi OS (other) > Raspberry Pi OS Lite (64 bit)
* Hostname = rpi5.lan.johnl.dev
* Capital City = Washington, DC
* Timezone = America/Boise
* Keyboard layout = us
* Username = john
* Enable SSH = ON
* Power on Raspberry Pi
* SSH into Raspberry Pi using IP address and john user

**if ssh server doesn't start on first boot then put empty file ssh in boot (fat) partition (same directory as start.elf)**

https://www.raspberrypi.com/news/cloud-init-on-raspberry-pi-os/


## Installation / Configuration

* Update Pi OS

```
sudo apt update
sudo apt full-upgrade -y
```

* Verify Hostname and update as needed  

```
hostnamectl
sudo hostnamectl set-hostname rpi5.lan.johnl.dev
```

* Verify Timezone and update as needed

```
timedatectl
sudo raspi-config nonint do_change_timezone "America/Boise"
```

* Configure Locale - raspberry pi OS defaults to en_GB

```
sudo raspi-config nonint do_change_locale "en_US.UTF-8 UTF-8"
localectl status
```

* Disable IPv6 Network

```
SYSCTLCONF="/etc/sysctl.d/70-disable-ipv6.conf"
echo 'net.ipv6.conf.all.disable_ipv6=1' | sudo tee -a $SYSCTLCONF > /dev/null
echo 'net.ipv6.conf.default.disable_ipv6=1' | sudo tee -a $SYSCTLCONF > /dev/null
echo 'net.ipv6.conf.lo.disable_ipv6=1' | sudo tee -a $SYSCTLCONF > /dev/null
echo ""
sudo sysctl --system
echo ""
sudo nmcli c mod "Wired connection 1" ipv6.method disabled
```

* Raspberry PI boot options

```
BOOTCONF="/boot/firmware/config.txt"
echo '' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtparam=sd_poll_once' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-wifi' | sudo tee -a $BOOTCONF > /dev/null
echo 'dtoverlay=disable-bt' | sudo tee -a $BOOTCONF > /dev/null
tail -n 4 $BOOTCONF
```

* Change systemd-journald to persistent and limit size

```
sudo mkdir /etc/systemd/journald.conf.d
sudo micro /etc/systemd/journald.conf.d/40-rpi-volatile-storage.conf
```

```
[Journal]
Storage=persistent
SystemMaxUse=1000M
```

```
systemd-analyze cat-config systemd/journald.conf
sudo mkdir -p /var/log/journal
sudo systemd-tmpfiles --create --prefix /var/log/journal
sudo systemctl restart systemd-journald
sudo journalctl --flush
```


## Restart rpi to boot into new config (so locale, IPv6, etc are updated)

* Install packages 

```
sudo apt install \
fastfetch \
micro \
bind9-dnsutils -y
```

* Disable cloud-init on future boots

```
sudo touch /etc/cloud/cloud-init.disabled
```


## Fixed IP address

* Set fixed IP address

```
sudo nmcli c show
sudo nmcli c show "Wired connection 1"
sudo nmcli c mod "Wired connection 1" ipv4.addresses 192.168.0.2/24 ipv4.method manual
sudo nmcli c mod "Wired connection 1" ipv4.gateway 192.168.0.1
sudo nmcli c mod "Wired connection 1" ipv4.dns "1.0.0.1 9.9.9.9" # use cloudflare and quad9 as centurylink fails on debian.org when using pihole/unbound
sudo nmcli c mod "Wired connection 1" ipv4.dns-options "timeout:2" # 2 second timeout to try next dns server
sudo nmcli c show "Wired connection 1"
sudo nmcli c down "Wired connection 1" && sudo nmcli c up "Wired connection 1"
```

* Revert to DHCP IP address (when changing networks)

```
sudo nmcli c show
sudo nmcli c show "Wired connection 1"
sudo nmcli c mod "Wired connection 1" ipv4.method auto ipv4.addresses "" ipv4.gateway "" ipv4.dns "" ipv4.dns-options ""
sudo nmcli c show "Wired connection 1"
sudo nmcli c down "Wired connection 1" && sudo nmcli c up "Wired connection 1"
```


## Clone this repository

```
sudo apt install git
git clone https://github.com/johnlevandowski/Raspberry-Pi-Server.git $HOME/Documents/GitHub/Raspberry-Pi-Server
```


## microSD card optimizations

* Disable rpi-swap writing to /var/swap when using microSD card

```
sudo mkdir /etc/rpi/swap.conf.d
SWAPCONF="/etc/rpi/swap.conf.d/99-disable-swap.conf"
echo '[Main]' | sudo tee -a $SWAPCONF > /dev/null
echo 'Mechanism=zram' | sudo tee -a $SWAPCONF > /dev/null
```

* Change timesyncd write interval (/var/lib/systemd/timesync/clock) when using microSD card

```
sudo mkdir /etc/systemd/timesyncd.conf.d
TIMECONF="/etc/systemd/timesyncd.conf.d/99-time-sync.conf"
echo '[Time]' | sudo tee -a $TIMECONF > /dev/null
echo 'SaveIntervalSec=60m' | sudo tee -a $TIMECONF > /dev/null
```

* Find files written to

```
sudo find / -xdev -type f -mmin -60
```


## Bootloader updates

```
sudo rpi-eeprom-update
```

* Reboot, then update EEPROM as needed using sudo rpi-eeprom-update -a and then reboot after updating

[Enable TRIM support](https://www.jeffgeerling.com/blog/2020/enabling-trim-on-external-ssd-on-raspberry-pi) - not supported on sandisk extreme pro usb SSD flash drive
