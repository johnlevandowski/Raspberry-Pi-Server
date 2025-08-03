#!/bin/bash

# Install 7zip
# sudo apt install 7zip

# Install rclone and configure remotes
# curl -fsSL https://rclone.org/install.sh -o rclone-install.sh
# sudo bash rclone-install.sh
#
# rclone config
# Use web browser to automatically authenticate rclone with remote? = no

# cp ~/install/cron/share-backup.sh ~/cron/
# cp ~/install/cron/sample.env ~/cron/.env
# chmod +x ~/cron/*.sh
# nano ~/cron/.env

# Find misc files to delete
# find /share/ -name ".DS_Store" -type f -print -delete
# find /share/ -name "desktop.ini" -type f -print -delete
# find /share/ -name "thumbs.db" -type f -print -delete
# find /share/ -name ".~lock.*" -type f
# find /share/ -name ".git" -type d

# crontab -e
# 1 * * * * bash ~/cron/share-backup.sh

source ~/cron/.env

# Don't run if script is currently running
script_name="bash /home/john/cron/share-backup.sh"
for pid in $(pgrep -f "$script_name"); do
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
EXCLUDE="--exclude .DS_Store --exclude desktop.ini --exclude thumbs.db --exclude *.itc2 --exclude .~lock.* --exclude .git/"

# Once an Hour Backup

# Copy Pictures to Box
rclone copy $EXCLUDE /share/Pictures box:Pictures

# Copy iTunes Music to Box
rclone copy $EXCLUDE /share/iTunes box:iTunes

# Sync lan to Box - so database backups are deleted
rclone sync $EXCLUDE /share/lan box:lan

# Copy Documents to Dropbox exluding gnucash log files
rclone copy --checksum --exclude gnucash/*.log $EXCLUDE /share/Documents dropbox:Documents

# Create Backup of Secure Documents and move to Dropbox
7zz a -mhe -p$password /tmp/securedocuments.7z /share/SecureDocuments/* -r  > /dev/null
rclone move --checksum /tmp/securedocuments.7z dropbox:SecureDocuments

if [ $HOUR = "22" ]; then

# Once a Day Backup

echo "Files on local that can be deleted"
echo "=================================================="
find /share/ -name ".DS_Store" -type f
find /share/ -name "desktop.ini" -type f
find /share/ -name "thumbs.db" -type f
find /share/ -name ".~lock.*" -type f
find /share/ -name ".git" -type d
echo ""

echo "Files on remote not on local"
echo "=================================================="
# Useful for showing files on remote that may be manually removed
rclone check -q --one-way box:Pictures /share/Pictures
rclone check -q --one-way box:iTunes /share/iTunes
rclone check -q --one-way dropbox:Documents /share/Documents
echo ""

echo "Create Backup of Documents and Move to Box"
echo "=================================================="
# 7zz a -mhe -p$password /tmp/backup-$YEAR-$MONTH-$DAY.7z /share/Documents/* -r  > /dev/null
# rclone move /tmp/backup-$YEAR-$MONTH-$DAY.7z box:$BACKUPDIR
tar -zcf /tmp/backup-$YEAR-$MONTH-$DAY.tar.gz /share/Documents
ls -lh /tmp/backup*.tar.gz
    if [ $DAY = "01" ]; then
        BACKUPDIR="Backups/"
        else BACKUPDIR="Backups/"$YEAR"/"$MONTH
    fi
echo $BACKUPDIR
rclone move /tmp/backup-$YEAR-$MONTH-$DAY.tar.gz box:$BACKUPDIR
echo ""

echo "Create Backup of Secure Documents and Move to Box"
echo "=================================================="
7zz a -mhe -p$password /tmp/securedocuments-$YEAR-$MONTH-$DAY.7z /share/SecureDocuments/* -r > /dev/null
ls -lh /tmp/securedocuments*.7z
    if [ $DAY = "01" ]; then
        BACKUPDIR="SecureBackups/"
        else BACKUPDIR="SecureBackups/"$YEAR"/"$MONTH
    fi
echo $BACKUPDIR
rclone move /tmp/securedocuments-$YEAR-$MONTH-$DAY.7z box:$BACKUPDIR
echo ""

echo "Box Quota Information"
echo "=================================================="
rclone about box:

fi
