#!/usr/bin/env bash

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
rm -rf ur-deploy
git clone git@github.com:ur-technology/ur-deploy.git
cd ur-deploy
curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "docker-compose version=`docker-compose -v`"
docker-compose -f docker-compose-$(hostname).yml down
IDS=$(docker ps -q)
if [[ !  -z  $IDS ]]; then
  docker kill $IDS
fi
IDS=$(docker ps -aq)
if [[ !  -z  $IDS ]]; then
  docker rm $IDS
fi
docker-compose -f docker-compose-$(hostname).yml up -d --build
