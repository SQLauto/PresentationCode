## first, see what docker commands we have available
docker --help


## Let's see the images we currently have downloaded
docker images


## what containers are actually configured and are they running
docker ps -a


## get an image
docker pull mcr.microsoft.com/mssql/server:2017-latest
docker pull mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu
docker pull mcr.microsoft.com/mssql/server:2019-CTP3.0-ubuntu
docker pull mcr.microsoft.com/mssql/server:2019-latest


docker ps -a

## remove an image
docker rmi 6243e166bb2a
## force remove
docker rmi 5494536a73c1 -f
## will fail if a container still exists


## create and run a container
docker run -e 'ACCEPT_EULA=Y' `
    -e 'SA_PASSWORD=$cthulhu1988' `
   -p 1433:1433 `
   --name Demo19 `
   -d mcr.microsoft.com/mssql/server:2019-latest

## check status
docker ps


## switch over to ADS, connect to the instance
## get the ip address
ipconfig


## stop a container
docker stop Demo19

## start an container
docker start Demo19

## now what's the status
docker ps -a


## create a container with a data volume
docker run -e 'ACCEPT_EULA=Y' `
-e 'SA_PASSWORD=$cthulhu1988' `
-p 1450:1433 `
--name Demo17vol `
-v sqlvol:/var/opt/mssql `
-d mcr.microsoft.com/mssql/server:2017-latest


## switch to ADS, create db & data   


## permissions in 2019 are different than 2017
docker exec -it Demo17vol "bash"

##bash commands
chgrp -R 0 /var/opt/mssql
chmod -R g=u /var/opt/mssql


##stop the running container
docker stop Demo17vol



## create a new container using the same volume
docker run -e 'ACCEPT_EULA=Y' `
    -e 'SA_PASSWORD=$cthulhu1988' `
    -p 1450:1433 `
    --name Demo19New `
    -v sqlvol:/var/opt/mssql `
    -d mcr.microsoft.com/mssql/server:2019-latest


  
docker ps -a

## stop the 2019 container & restart the 2017
docker stop Demo19New
docker start Demo17vol


docker ps -a

## will need to update thc container ID
docker logs Demo17vol








## shared drive and volumes
## first show the shared drives in Docker Desktop
docker run `
    --name DemoSharedVol `
    -p 1460:1433 `
    -e "ACCEPT_EULA=Y" `
    -e 'SA_PASSWORD=$cthulhu1988' `
    -v C:\Docker\SQL:/bu `
    -d mcr.microsoft.com/mssql/server:2019-latest


docker exec -it DemoSharedVol "bash"    


##switch to ADS & restore database





## control the container with dockerfiles
## show demodockerfile

## create a new image from dockerfile
## note: may need to copy & paste this, not F8
docker build -t demodockerfileimage .

docker images

## create a new container from new image
docker run `
    --name DemoCustom `
    -p 1470:1433 `
    -d `
    -e 'SA_PASSWORD=$cthulhu1988' `
    -e 'ACCEPT_EULA=Y' `
    demodockerfileimage

docker cp C:\Docker\sql\AdventureWorks2017.bak DemoCustom:/bu


docker exec -it DemoCustom "bash"    

docker logs DemoCustom


## go whole hog with Spawn





## clean up
docker stop Demo19
docker stop Demo19New
docker stop Demo17vol
docker stop DemoSharedVol
docker stop DemoCustom
docker rm Demo19
docker rm Demo19New
docker rm Demo17vol
docker rm DemoSharedVol
docker rm DemoCustom
docker volume rm sqlvol
docker rmi demodockerfileimage



docker ps -a
docker images


