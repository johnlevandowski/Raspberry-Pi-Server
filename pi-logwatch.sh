#!/bin/sh

echo "# Install logwatch"
sudo apt install logwatch -y
sudo mkdir /var/cache/logwatch
sudo cp /usr/share/logwatch/default.conf/logwatch.conf /etc/logwatch/conf/
echo ""

echo "# Configure Logwatch"
echo "~~~"
echo "sudo nano /etc/logwatch/conf/logwatch.conf"
echo "~~~"
echo "Output = mail"
echo "Format = html"
echo "MailTo = user@example.com"
echo "Detail = High"
echo "~~~"
echo ""

# cron emails
# sudo nano /etc/crontab
# MAILTO=user@example.com
# to test cron emails are working add:
# * * * * * root date
