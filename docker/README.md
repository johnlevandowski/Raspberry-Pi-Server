# Docker Base
~~~
sudo apt install curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
~~~

~~~
sudo nano /etc/docker/daemon.json
~~~

~~~
{
  "log-driver": "journald",
  "log-opts": {
    "tag": "{{.Name}}"
  }
}
~~~

# Create network with limited range so caddy server can have fixed IP for firewall rules
~~~
docker network create \
--driver=bridge \
--subnet=172.21.21.0/24 \
--ip-range=172.21.21.128/25 \
--gateway=172.21.21.1 \
caddy_network
~~~

~~~
docker network create \
--driver=bridge \
--subnet=172.21.53.0/24 \
--ip-range=172.21.53.128/25 \
--gateway=172.21.53.1 \
unbound_network
~~~

~~~
sudo systemctl restart docker
~~~

# Test Container
~~~
docker run hello-world
docker container list --all
docker container remove (NAMES listed)
docker system df
docker system prune -a
~~~

# Copy docker directories to root of home directory for use
~~~
cp -r ~/install/docker/ ~/docker/
cp ~/docker/caddy/sample.env ~/docker/caddy/.env
cp ~/docker/pihole/sample.env ~/docker/pihole/.env
~~~

# Update docker .env files with passwords/keys
~~~
nano ~/docker/caddy/.env
nano ~/docker/pihole/.env
~~~

# Enable memory reporting in docker stats for raspberry pi by adding the follwing config to end of line 1
~~~
nano /boot/firmware/cmdline.txt
cgroup_enable=cpuset cgroup_enable=memory
~~~

# Compare local docker directory vs github version
~~~
git -C ~/install/ pull
diff -r --exclude=.env --exclude=*.md ~/docker/ ~/install/docker/
 ~~~
