#!/bin/bash -x

docker buildx version
docker buildx ls
mkdir -p ~/.docker
touch ~/.docker/config.json
cat ~/.docker/config.json
cat /etc/docker/daemon.json
docker info 