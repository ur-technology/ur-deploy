#!/usr/bin/env bash

ALL_NODES="bootnode-1 bootnode-2 explorer-1 miner-1 transaction-relay-1 identifier-1"
ALL_NODES="miner-1"

for h in $ALL_NODES
do
  scp -F ssh_config -o StrictHostKeyChecking=no ~/.ssh/id_rsa_ur_capital root@$h:/root/.ssh/id_rsa
  scp -F ssh_config -o StrictHostKeyChecking=no ./prepare-local-host.sh root@$h:
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h ./prepare-local-host.sh $h
done
