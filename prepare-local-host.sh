#!/usr/bin/env bash

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

if [[ "`uname -n`" == "identifier-1" ]]; then
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

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

rm -rf ur-deploy
git clone git@github.com:ur-technology/ur-deploy.git
cd ur-deploy
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
