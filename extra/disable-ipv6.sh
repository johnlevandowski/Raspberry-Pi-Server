#!/bin/sh

echo "# Disable IPv6 Network"
SYSCTLCONF="/etc/sysctl.d/70-disable-ipv6.conf"
echo 'net.ipv6.conf.all.disable_ipv6=1' | sudo tee -a $SYSCTLCONF > /dev/null
echo 'net.ipv6.conf.default.disable_ipv6=1' | sudo tee -a $SYSCTLCONF > /dev/null
echo 'net.ipv6.conf.lo.disable_ipv6=1' | sudo tee -a $SYSCTLCONF > /dev/null
echo ""
sudo sysctl -p -f $SYSCTLCONF
echo ""
ip address
