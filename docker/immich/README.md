# Immich

Follow the instructions at  
https://immich.app/docs/install/docker-compose  

Add external volume to compose.yaml  

~~~
      - /share/Pictures:/share/Pictures:ro
~~~

Add folders to backup to compose.yaml  

~~~
      - ${BACKUP_LOCATION}:/usr/src/app/upload/backups
      - ${LIBRARY_LOCATION}:/usr/src/app/upload/library
      - ${PROFILE_LOCATION}:/usr/src/app/upload/profile
      - ${UPLOADS_LOCATION}:/usr/src/app/upload/upload
~~~

Comment out ports in compose.yaml immich_server  

Add caddy_network to 4 services in compose.yaml  

~~~
    networks:
      caddy_network:
~~~

~~~
networks:
  caddy_network:
    external: true
~~~

Reduce redis log verbosity in compose.yaml redis: section  
~~~
    command: redis-server --loglevel warning
~~~

Add folders to backup to .env  

~~~
BACKUP_LOCATION=/share/lan/rpi5/immich/backups
LIBRARY_LOCATION=/share/lan/rpi5/immich/library
PROFILE_LOCATION=/share/lan/rpi5/immich/profile 
UPLOADS_LOCATION=/share/lan/rpi5/immich/upload
~~~

Add timezone to .env  

~~~
TZ=US/Mountain
~~~

Change IMMICH_VERSION in .env  
Change DB_PASSWORD in .env  

~~~
mkdir -p /share/lan/rpi5/immich
~~~

Create immich-machine-learning on virtualbox  
https://immich.app/docs/guides/remote-machine-learning/  

Immich > Administration > Settings > Machine Learning Settings > URL = http://192.168.0.12:3003 (virtualbox)  
Immich > Administration > Settings > Machine Learning Settings > Facial Recognition > Enable facial recognition = OFF  
Immich > Administration > External Library > Create Library > Path = /share/Pictures/  

After import of external library  
Immich > Administration > Settings > Machine Learning Settings > URL = http://immich-machine-learning:3003  
