#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "prod" ]]; then
  echo "running $0 in prod mode"
elif [[ "$UR_ENV" == "dev" ]]; then
  echo "running $0 in dev mode"
else
  echo "Usage: $0 prod|dev"
  exit 1
fi

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
cd ur-deploy
BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')
docker-compose up -d --build $BASE_HOSTNAME # NOTE: this will use the .env file created by preapre-local-host.sh
docker logs $BASE_HOSTNAME
