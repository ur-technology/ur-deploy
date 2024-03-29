#!/usr/bin/env bash

UR_ENV=$1
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
  scp -F ssh_config -o StrictHostKeyChecking=no ~/.ssh/id_rsa root@$h:/root/.ssh/id_rsa
  scp -F ssh_config -o StrictHostKeyChecking=no ./prepare-local-host.sh root@$h:
  scp -F ssh_config -o StrictHostKeyChecking=no ./start-docker-script.sh root@$h:
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h ./prepare-local-host.sh $UR_ENV
done

for h in $ALL_NODES
do
  echo ""
  echo "*********************************************"
  echo "Starting docker script $h..."
  echo "*********************************************"
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h ./start-docker-script.sh $UR_ENV
done
