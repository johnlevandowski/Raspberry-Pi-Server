# Immich

Follow the instructions at  
https://immich.app/docs/install/docker-compose  

Add external volume to compose.yaml  

~~~
      - /share/pictures:/share/pictures:ro
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

Add folders to backup to .env  

~~~
BACKUP_LOCATION=/share/pictures/immich/backups
LIBRARY_LOCATION=/share/pictures/immich/library
PROFILE_LOCATION=/share/pictures/immich/profile 
UPLOADS_LOCATION=/share/pictures/immich/upload
~~~

Add timezone to .env  

~~~
TZ=US/Mountain
~~~

~~~
mkdir /share/pictures/immich
~~~

Change IMMICH_VERSION in .env  
Change DB_PASSWORD in .env  

Create immich-machine-learning on virtualbox  
https://immich.app/docs/guides/remote-machine-learning/  

Immich > Administration > Settings > Machine Learning Settings > URL = change to virtualbox machine temporarily for mass load of pictures  
Immich > Administration > External Library > Create Library > Path = /share/pictures/2003 to test  
