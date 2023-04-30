#!/bin/sh

# Configure rclone remotes
#
# rclone config
# Use auto config? = no
 
# Configure to run via cron
#
# mkdir ~/cron
# cp /share/Documents/Linux/Raspberry-Pi-Server/share-backup.sh ~/cron/

# crontab -e
# 1 * * * * ~/cron/share-backup.sh

# Change all share file/folder permissions
# chmod -R 777 /share/*
# Find and delete all .DS_Store files
# find /share/ -name ".DS_Store" -type f -print -delete

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
EXCLUDE="--exclude .DS_Store --exclude desktop.ini --exclude thumbs.db --exclude *.itc2 --exclude .~lock.*"

# Once an Hour Backup

# Copy Pictures to Box
rclone copy $EXCLUDE /share/Pictures box:/Pictures

# Copy iTunes Music to Box
rclone copy $EXCLUDE /share/iTunes box:/iTunes

# Copy Documents to Dropbox exluding gnucash log files
rclone copy --checksum --exclude gnucash/*.log $EXCLUDE /share/Documents dropbox:/Documents

if [ $HOUR = "22" ]; then

# Once a Day Backup

echo "Files on remote not on local"
echo "=================================================="
# Useful for showing files on remote that may be manually removed
rclone check -q --one-way box:/Pictures /share/Pictures
rclone check -q --one-way box:/iTunes /share/iTunes
rclone check -q --one-way dropbox:/Documents /share/Documents
echo ""

echo "Create Backup of Documents and Move to Box"
echo "=================================================="
tar --exclude-vcs -zcf /tmp/backup-$YEAR-$MONTH-$DAY.tar.gz /share/Documents
ls -lh /tmp/backup*.tar.gz
    if [ $DAY = "01" ]; then
        BACKUPDIR="/Backups/"
        else BACKUPDIR="/Backups/"$YEAR"/"$MONTH
    fi
echo $BACKUPDIR
rclone move /tmp/backup-$YEAR-$MONTH-$DAY.tar.gz box:$BACKUPDIR
echo ""

echo "Box Quota Information"
echo "=================================================="
rclone about box:

fi
