#!/bin/sh

echo "# Mount /tmp on tmpfs"
sudo nano /etc/fstab
tmpfs  /tmp  tmpfs  defaults,noatime,nosuid,nodev  0  0

# Find files written to disk in last day
sudo find / -xdev -mtime -1 -print
