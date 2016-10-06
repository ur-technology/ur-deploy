#!/usr/bin/env bash

ALL_NODES="bootnode-1 bootnode-2 explorer-1 identifier-1 miner-1 rpc-1"

ALL_NODES="bootnode-1 bootnode-2 explorer-1 miner-1"

for h in $ALL_NODES
do
  scp -F ssh_config -o StrictHostKeyChecking=no ~/.ssh/id_rsa_ur_capital $h:/root/.ssh/id_rsa
  scp -F ssh_config -o StrictHostKeyChecking=no ./prepare-local-host.sh $h:
  ssh -F ssh_config -o StrictHostKeyChecking=no $h ./prepare-local-host.sh $h
  ssh -F ssh_config -o StrictHostKeyChecking=no $h "cd ur-deploy; docker logs \`hostname\`"
done
