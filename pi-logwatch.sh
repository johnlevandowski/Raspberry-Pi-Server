#!/bin/sh

echo "# Install logwatch"
sudo apt install logwatch -y
sudo mkdir /var/cache/logwatch
echo ""

echo "# Configure Logwatch"
LOGWATCHCONF="/etc/logwatch/conf/logwatch.conf"
echo 'Output = mail' | sudo tee $LOGWATCHCONF > /dev/null
echo 'MailTo = user@example.com' | sudo tee -a $LOGWATCHCONF > /dev/null
echo 'Detail = High' | sudo tee -a $LOGWATCHCONF > /dev/null
echo 'Service = "-zz-disk_space"' | sudo tee -a $LOGWATCHCONF > /dev/null
cat $LOGWATCHCONF
echo "~~~"
echo "sudo nano /etc/logwatch/conf/logwatch.conf"
echo "~~~"
echo "Update email address"
echo "~~~"
echo ""
