#!/usr/bin/env bash

ALL_NODES="bootnode1 bootnode2 explorer miner-1 transaction-relay-1"

ALL_NODES="bootnode2"

for h in $ALL_NODES
do
  scp -F ssh_config -o StrictHostKeyChecking=no ~/.ssh/id_rsa_ur_capital $h:/root/.ssh/id_rsa
  scp -F ssh_config -o StrictHostKeyChecking=no ./prepare-local-host $h:
  ssh -F ssh_config -o StrictHostKeyChecking=no $h ./prepare-local-host.sh
done
