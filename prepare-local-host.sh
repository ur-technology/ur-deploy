#!/usr/bin/env bash

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

if ! [ -x "$(command -v docker)" ]; then
  # install docker
  apt-get update
  apt-get install -y apt-transport-https ca-certificates
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
  apt-get purge lxc-docker
  apt-cache policy docker-engine
  apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual docker-engine
  service docker start
fi

if ! [ -x "$(command -v docker-compose)" ]; then
  # install docker-compose
  curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

rm -rf ur-deploy
git clone git@github.com:ur-technology/ur-deploy.git
cd ur-deploy

if [[ "`hostname`" == *"queue-processor"* || "`hostname`" == *"identifier"* ]]; then
  if [[ -d files/ur-money-queue-processor ]]; then
    cd files/ur-money-queue-processor
    git fetch
    git checkout dev
    git reset --hard origin/dev
    cd -
  else
    git clone --depth=1 --branch=dev git@github.com:ur-technology/ur-money-queue-processor.git files/ur-money-queue-processor
  fi
fi

docker-compose down
IDS=$(docker ps -q)
if [[ !  -z  $IDS ]]; then
  docker kill $IDS
fi
IDS=$(docker ps -aq)
if [[ !  -z  $IDS ]]; then
  docker rm $IDS
fi
docker-compose up -d --build $(hostname)
docker logs $(hostname)
