#!/usr/bin/env bash

ALL_NODES="bootnode1 bootnode2 explorer miner-1 transaction-relay-1"

echo ""
for h in $ALL_NODES
do
  # scp -F ssh_config ~/.ssh/id_rsa_ur_capital $h:/root/.ssh/id_rsa
  # ssh -F ssh_config $h "git clone git@github.com:ur-technology/ur-deploy.git"
  apt-get install docker-compose
done
