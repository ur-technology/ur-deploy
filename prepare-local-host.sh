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
BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')

# download latest version of ur-money-queue-processor code
if [[ "$BASE_HOSTNAME" == *"queue-processor"* || "$BASE_HOSTNAME" == *"identifier"* ]]; then
  if [[ "$UR_ENV" == "prod" ]]; then
    BRANCH=master
  else
    BRANCH=dev
  fi
  if [[ -d files/ur-money-queue-processor ]]; then
    cd files/ur-money-queue-processor
    git fetch
    git checkout $BRANCH
    git reset --hard origin/$BRANCH
    cd -
  else
    git clone --depth=1 --branch=$BRANCH git@github.com:ur-technology/ur-money-queue-processor.git files/ur-money-queue-processor
  fi
fi

# prepare .env file for dockerfile
cp env.dockerfile.$UR_ENV .env
PRIVILEGED_UTI_OUTBOUND_PASSWORD=""
if [[ "$BASE_HOSTNAME" == *"queue-processor"* || "$BASE_HOSTNAME" == *"identifier"* ]]; then
  echo "Please enter passphrase for privileged UTI-outbound address [wQEqfsik6i3CspYqVdh]: "
  read -s PRIVILEGED_UTI_OUTBOUND_PASSWORD
  echo ""
  if  [[ -z $PRIVILEGED_UTI_OUTBOUND_PASSWORD  ]]; then
    PRIVILEGED_UTI_OUTBOUND_PASSWORD=wQEqfsik6i3CspYqVdh
  fi
fi
echo 'PRIVILEGED_UTI_OUTBOUND_PASSWORD="$PRIVILEGED_UTI_OUTBOUND_PASSWORD"' >> .env

apt-get install -y wget unzip
wget --quiet https://github.com/ur-technology/go-ur/releases/download/UR-v0.0.1-alpha/gur-linux-amd64.zip && \
  unzip -d files gur-linux-amd64.zip gur
# git clone https://github.com/ur-technology/go-ur.git; make -C go-ur gur-linux-amd64; cp go-ur/build/bin/gur-linux-amd64 files/gur

docker-compose down
IDS=$(docker ps -q)
if [[ !  -z  $IDS ]]; then
  docker kill $IDS
fi
IDS=$(docker ps -aq)
if [[ ! -z $IDS ]]; then
  docker rm $IDS
fi
echo "all done preparing local host"
