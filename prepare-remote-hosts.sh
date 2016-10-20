#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "prod" ]]; then
  ALL_NODES="just-one-node"
elif [[ "$UR_ENV" == "dev" ]]; then
  ALL_NODES="dev-bootnode-1 dev-bootnode-2 dev-explorer-1 dev-miner-1 dev-transaction-relay-1 dev-identifier-1"
else
  echo "Usage: $0 prod|dev"
  exit 1
fi

echo ALL_NODES=$ALL_NODES
for h in $ALL_NODES
do
  echo ""
  echo "*********************************************"
  echo "Preparing server $h..."
  echo "*********************************************"
  scp -F ssh_config -o StrictHostKeyChecking=no ~/.ssh/id_rsa_ur_capital root@$h:/root/.ssh/id_rsa
  scp -F ssh_config -o StrictHostKeyChecking=no ./prepare-local-host.sh root@$h:
  scp -F ssh_config -o StrictHostKeyChecking=no ./start-docker-script.sh root@$h:
  scp -F ssh_config -o StrictHostKeyChecking=no ./env.$UR_ENV root@$h:.env
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h ./prepare-local-host.sh
done

for h in $ALL_NODES
do
  echo ""
  echo "*********************************************"
  echo "Starting docker script $h..."
  echo "*********************************************"
  ssh -F ssh_config -o StrictHostKeyChecking=no root@$h ./start-docker-script.sh
done
