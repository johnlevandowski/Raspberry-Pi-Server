Bookmarks
=========

Update bookmarks script
```
rclone copy /share/Documents/Linux/Raspberry-Pi-Server/docker/caddy/site/boomarks/index.html /home/john/docker/caddy/site/bookmarks --dry-run
```

Copy exported bookmarks.html from firefox to use
```
rclone copy /var/home/john/.var/app/org.mozilla.firefox/config/mozilla/firefox/gfyh3ije.default-release/bookmarks.html /var/home/john/rpi5/Documents/backup/Firefox --dry-run
rclone copy /share/Documents/backup/Firefox/bookmarks.html /home/john/docker/caddy/site/bookmarks --dry-run
```
