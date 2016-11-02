#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail

rm -rf ~/ur-money-queue-processor
cp -R ~/files/ur-money-queue-processor ~/
mkdir -p ~/ur_data/keystore
cp ~/files/keystore.$UR_DEV/* ~/ur_data/keystore/

nohup ~/files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1" </dev/null > ~/ur_data/gur.log 2>&1 &

cd ~/ur-money-queue-processor
cp env.node.$UR_ENV .env
echo "PRIVILEGED_UTI_OUTBOUND_PASSWORD=$PRIVILEGED_UTI_OUTBOUND_PASSWORD" >> .env
npm install
typings install
# npm run-script debug
npm start
