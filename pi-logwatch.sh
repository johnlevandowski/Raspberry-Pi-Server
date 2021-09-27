#!/bin/sh

echo "# Install logwatch"
sudo apt install logwatch -y
sudo mkdir /var/cache/logwatch
echo ""

echo "# Configure Logwatch"
LOGWATCHCONF="/etc/logwatch/conf/logwatch.conf > /dev/null"
echo 'Output = mail' | sudo tee $LOGWATCHCONF
echo 'MailTo = user@example.com' | sudo tee -a $LOGWATCHCONF
echo 'Detail = High' | sudo tee -a $LOGWATCHCONF
echo 'Service = "-zz-disk_space"' | sudo tee -a $LOGWATCHCONF
echo "~~~"
echo "sudo nano /etc/logwatch/conf/logwatch.conf"
echo "~~~"
echo "Update email address"
echo "~~~"
echo ""

# cron emails
# sudo nano /etc/crontab
# MAILTO=user@example.com
# to test cron emails are working add:
# * * * * * root date
