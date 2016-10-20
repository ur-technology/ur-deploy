#!/usr/bin/env bash

echo "in start-docker-script: pwd=`pwd`"
echo ""
echo "before sourcing: UR_DEV=$UR_DEV, FOO=$FOO"
echo ""
echo "FOO=BAR" >> ./.env
echo "contents of .env:"
cat ./.env
echo ""
echo "calling source"
source ./.env
echo "after sourcing: UR_DEV=$UR_DEV, FOO=$FOO"
echo ""

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

cd ur-deploy
BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')
docker-compose up -d --build $BASE_HOSTNAME
docker logs $BASE_HOSTNAME
