#!/usr/bin/env bash

source ./.env

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

cd ur-deploy
BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')
docker-compose up -d --build $BASE_HOSTNAME
docker logs $BASE_HOSTNAME
