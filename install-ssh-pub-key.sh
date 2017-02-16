#!/usr/bin/env bash

set -x

UR_ENV=$1
NEW_PUB_KEY=$2
if [[ "$UR_ENV" == "production" ]]; then
  # ALL_NODES="bootnode-1a bootnode-2a explorer-1 transaction-importer-1 transaction-importer-2 transaction-importer-3 transaction-importer-4 transaction-importer-5 transaction-relay-1 transaction-relay-2 identifier-1"
  ALL_NODES="just-one-node"
elif [[ "$UR_ENV" == "staging" ]]; then
  # ALL_NODES="dev-bootnode-1 dev-bootnode-2 dev-explorer-1 dev-miner-1 dev-miner-2 dev-transaction-relay-1 dev-identifier-1"
  ALL_NODES="just-one-node"
else
  echo "Usage: $0 production|staging"
  exit 1
fi

for h in $ALL_NODES
do
  echo ""
  echo "*********************************************"
  echo "Preparing server $h..."
  echo "*********************************************"
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h "echo '${NEW_PUB_KEY}' >> /root/.ssh/authorized_keys"
done
