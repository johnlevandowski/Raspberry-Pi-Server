#!/bin/bash

# sudo apt install wakeonlan
# cp ~/install/cron/wakepc.sh ~/cron/
# chmod +x ~/cron/*.sh
# crontab -e
# 0 8 * * * /bin/bash -c "~/cron/wakepc.sh"

wakeonlan 12:34:56:78:90:12 > /dev/null
