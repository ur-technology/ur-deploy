#!/usr/bin/env bash

ALL_NODES="bootnode-1 bootnode-2 explorer-1 miner-1 transaction-relay-1 identifier-1"

for h in $ALL_NODES
do
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h "echo '';echo '***************'; echo $h:; docker logs $h"
done
