#!/bin/bash

# sudo apt install wakeonlan
# crontab -e
# 0 8 * * * /bin/bash -c "~/install/cron/wakepc.sh"

wakeonlan 12:34:56:78:90:12 > /dev/null
