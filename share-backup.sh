#!/bin/sh

# Configure rclone remotes
#
# rclone config
# Use auto config? = no
 
# Configure to run via cron
#
# sudo nano /etc/crontab
# 0 22 * * * john /home/john/share-backup.sh

# Change all share file/folder permissions
# chmod -R 777 /share/*

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
