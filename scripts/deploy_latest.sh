#!/usr/bin/env bash

git pull

echo "$(date --utc +%FT%TZ): Deploy new changes"

echo "$(date --utc +%FT%TZ): Running build"

docker compose rm -f

docker compose build

OLD_CONTAINERS=$(docker ps -aqf "name=express_app")

echo "$(date --utc +%FT%TZ): Scaling to 2 containers"

docker compose up -d --no-deps --scale app=2 --no-recreate app

sleep 30

echo "$(date --utc +%FT%TZ): Removing old containers"

docker container rm -f $OLD_CONTAINERS

docker compose up -d --no-deps --scale app=1 --no-recreate app

echo "$(date --utc +%FT%TZ): Reloading Caddy..."

CADDY_CONTAINER=$(docker ps -qf "name=caddy")

docker exec -it $CADDY_CONTAINER caddy reload --config /etc/caddy/Caddyfile

echo "$(date --utc %FT%TZ): Done"

