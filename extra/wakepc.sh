#!/bin/sh

# sudo apt install wakeonlan
# crontab -e
# 0 8 * * * ~/cron/wakepc.sh

wakeonlan 12:34:56:78:90:12 > /dev/null
