# smartmontools

## Install
~~~
sudo apt install smartmontools -y
~~~

## Change disk check interval (seconds)
~~~
sudo nano /etc/default/smartmontools
~~~

~~~
smartd_opts="--interval=86400"
~~~

~~~
sudo systemctl restart smartd.service
~~~
