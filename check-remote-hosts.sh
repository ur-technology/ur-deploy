#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "prod" ]]; then
  ALL_NODES="bootnode-1 bootnode-2 explorer-1 miner-1 transaction-relay-1 identifier-1"
elif [[ "$UR_ENV" == "dev" ]]; then
  ALL_NODES="dev-bootnode-1 dev-bootnode-2 dev-explorer-1 dev-miner-1 dev-transaction-relay-1 dev-identifier-1"
else
  echo "Usage: $0 prod|dev"
  exit 1
fi

for h in $ALL_NODES
do
  BASE_HOSTNAME=$(echo $h | sed -e 's/^dev\-//')
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h "echo '';echo '***************'; echo $h:; docker logs $BASE_HOSTNAME"
done
