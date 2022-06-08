#!/bin/sh

# Configure rclone remotes
#
# rclone config
# Use auto config? = no
 
# Configure to run via cron
#
# mkdir ~/cron
# cp ~/pi.johnlevandowski.com/share-backup.sh ~/cron/
# crontab -e
# 1 * * * * ~/cron/share-backup.sh

# Change all share file/folder permissions
# chmod -R 777 /share/*

# Show all files on source not on destination
# Useful for showing files on remote that may be manually removed
# rclone check box:/iTunes /share/iTunes --one-way

# Don't run if script is currently running
script_name=$(basename -- "$0")
for pid in $(pidof -x $script_name); do
    if [ $pid != $$ ]; then
        echo "[$(date)] : $script_name : Process is already running with PID $pid"
        exit 1
    fi
done

# Variables
DATE=$(date +%Y%m%d%H)
YEAR=$(echo $DATE | cut -c1-4)
MONTH=$(echo $DATE | cut -c5-6)
DAY=$(echo $DATE | cut -c7-8)
HOUR=$(echo $DATE | cut -c9-10)
EXCLUDE="--exclude .DS_Store --exclude desktop.ini --exclude thumbs.db --exclude *.itc2"

if [ $HOUR = "22" ]; then

# Once a Day Backup

echo "Copy Pictures to Box"
echo "=================================================="
rclone copy $EXCLUDE /share/Pictures box:/Pictures
echo ""

echo "Copy iTunes Music to Box"
echo "=================================================="
rclone copy $EXCLUDE /share/iTunes box:/iTunes
echo ""

echo "Copy Documents to Dropbox"
echo "=================================================="
# rclone copy $EXCLUDE /share/Documents/Taxes dropbox:/Documents/Taxes --dry-run
echo ""

echo "Create Backup of Documents and Move to Box"
echo "=================================================="
# tar -zcpf /tmp/backup-$YEAR-$MONTH-$DAY.tar.gz /share/Documents
    if [ $DAY = "01" ]; then
        BACKUPDIR="/Backups/"
        else BACKUPDIR="/Backups/"$YEAR"/"$MONTH
    fi
echo $BACKUPDIR
# rclone move /tmp/backup-$YEAR-$MONTH-$DAY.tar.gz box:$BACKUPDIR --dry-run
echo ""

echo "Box Quota Information"
echo "=================================================="
rclone about box:

else

# Once an Hour Backup

rclone copy $EXCLUDE /share/Pictures box:/Pictures
rclone copy $EXCLUDE /share/iTunes box:/iTunes

fi
