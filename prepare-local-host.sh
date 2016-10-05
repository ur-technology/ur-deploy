#!/usr/bin/env bash


echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
rm -rf ur-deploy
git clone git@github.com:ur-technology/ur-deploy.git
cd ur-deploy
curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker kill $(docker-compose ps -q)
docker rm $(docker-compose ps -q)
docker-compose -f docker-compose-$(hostname).yml up -d --build
