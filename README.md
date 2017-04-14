# squeezecenter-docker

Run Logitech Media Server as Docker image. 

Package sources you find here: http://downloads.slimdevices.com/


## inititalize volumes (nfs here):

### volume with the music files 
docker volume create --driver local --opt type=nfs --opt o=addr=x.x.x.x,ro --opt device=:/share/music music

### volume with squeecenter data

with nfs you need to take care to have the squeezebox user with the same gid on the nfs server as in the Dockerfile

docker volume create --driver local --opt type=nfs --opt o=addr=x.x.x.x,rw --opt device=:/share/squeeze squeeze_data

### run the container

    docker run -d \
           -v music:/music \
           -v squeeze_data:/var/lib/squeezeboxserver \
           -v /etc/localtime:/etc/localtime:ro \
           -p 9000:9000 \
           -p 3483:3483 \
           -p 3483:3483/udp \
           -p 9090:9090 \
           -p 9005:9005 \
           pmumenthaler/squeezecenter


# TODO
* fix spotify connection issue
* add ssl support

