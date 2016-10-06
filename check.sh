#!/usr/bin/env bash

ALL_NODES="bootnode-1 bootnode-2 explorer-1 identifier-1 miner-1 rpc-1.sh"

ALL_NODES="bootnode-1 bootnode-2 explorer-1 miner-1"

for h in $ALL_NODES
do
  ssh -F ssh_config -o StrictHostKeyChecking=no $h "cd ur-deploy; docker exec -it \`hostname\` ./attach.sh"
done
