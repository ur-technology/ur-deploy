#!/usr/bin/env bash

source ./.env

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

cd ur-deploy
docker-compose up -d --build $BASE_HOSTNAME
docker logs $BASE_HOSTNAME
