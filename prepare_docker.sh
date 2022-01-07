#!/bin/sh

sudo chown ianbel:ianbel -R ./nginx-proxy/data

docker docker stop $(docker ps -a -q)
docker volume prune -f
docker network prune -f
docker system prune -f

docker network create nginx-proxy
docker volume create static
docker volume create media
docker-compose up --build -d
./nginx-proxy/docker-compose up --build -d