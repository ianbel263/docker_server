#!/bin/sh

sudo chown ianbel:ianbel -R ./nginx_proxy/data

docker docker stop $(docker ps -a -q)
docker volume prune -f
docker network prune -f
docker system prune -f

docker network create \
  --driver=bridge \
  --subnet=172.29.0.0/16 \
  --gateway=172.29.0.1 \
  nginx-proxy
docker volume create static
docker volume create media
docker-compose -f /home/ianbel/geekshop/docker-compose.yml up --build -d
docker-compose -f ./nginx_proxy/docker-compose.yml up --build -d