#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "production" ]]; then
  echo "running $0 in production mode"
elif [[ "$UR_ENV" == "staging" ]]; then
  echo "running $0 in staging mode"
else
  echo "Usage: $0 production|staging"
  exit 1
fi

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
cd ur-deploy
BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')
if [[ "$BASE_HOSTNAME" == *"bootnode"* && "$UR_ENV" == "staging" ]]; then
BASE_HOSTNAME=${BASE_HOSTNAME}a

docker-compose up -d --build $BASE_HOSTNAME # NOTE: this will use the .env file created by preapre-local-host.sh
docker logs $BASE_HOSTNAME
