# Docker Base
~~~
sudo apt install curl
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
~~~

~~~
sudo nano /etc/docker/daemon.json
{
  "log-driver": "journald"
}
~~~

~~~
docker network create \
--driver=bridge \
--subnet=172.21.21.0/24 \
--ip-range=172.21.21.0/24 \
--gateway=172.21.21.1 \
caddy_network
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
docker system prune
~~~

#Copy docker directories to root of home directory for use
~~~
cp -r ~/install/docker/ ~/docker/
cp ~/docker/caddy/sample.env ~/docker/caddy/.env
cp ~/docker/pihole/sample.env ~/docker/pihole/.env
~~~

#Update docker .env files with passwords/keys
~~~
nano ~/docker/caddy/.env
nano ~/docker/pihole/.env
~~~
