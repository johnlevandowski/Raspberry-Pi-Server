#!/bin/sh

# Configure rclone remotes
#
# rclone config
# Use auto config? = no
 
# Configure to run via cron
#
# mkdir ~/cron
# cp ~/pi.johnlevandowski.com/share-backup.sh ~/cron/share-backup.sh
# crontab -e
# 0 22 * * * ~/cron/share-backup.sh

# Change all share file/folder permissions
# chmod -R 777 /share/*

# Don't run if script is currently running
script_name=$(basename -- "$0")
for pid in $(pidof -x $script_name); do
    if [ $pid != $$ ]; then
        echo "[$(date)] : $script_name : Process is already running with PID $pid"
        exit 1
    fi
done

# Variables
DATE=$(date +%Y%m%d)
YEAR=$(echo $DATE | cut -c1-4)
MONTH=$(echo $DATE | cut -c5-6)
DAY=$(echo $DATE | cut -c7-8)
EXCLUDE="--exclude .DS_Store --exclude desktop.ini --exclude thumbs.db"

echo "# Sync Pictures to Box"
echo ""
rclone sync $EXCLUDE -v /share/Pictures box:/Pictures --dry-run
echo ""

echo "# Sync iTunes Music to Box excluding album artwork cache files"
echo ""
rclone sync $EXCLUDE --exclude *.itc2 -v /share/iTunes box:/iTunes --dry-run
echo ""

echo "# Sync Documents to Dropbox"
echo ""
# rclone sync $EXCLUDE -v /share/Documents/Taxes dropbox:/Documents/Taxes --dry-run
echo ""

echo "# Create backup of Documents and move to Box"
echo ""
# tar -zcpf /share/backup-$YEAR-$MONTH-$DAY.tar.gz /share/Documents
if [ $DAY = "01" ]; then
     BACKUPDIR="/Backups/"
else BACKUPDIR="/Backups/"$YEAR"/"$MONTH
fi
echo $BACKUPDIR
# rclone move -v /share/backup-$YEAR-$MONTH-$DAY.tar.gz box:$BACKUPDIR --dry-run
echo ""

echo "# Box Quota Information"
echo ""
rclone about box:
