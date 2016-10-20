#!/bin/bash

echo "in script: UR_DEV=$UR_DEV"

. files/gur-options.sh
set -eo pipefail

nohup files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1" </dev/null > ~/ur_data/gur.log 2>&1 &

rm -rf ~/ur-money-queue-processor
cp -R files/ur-money-queue-processor ~/
cd ur-money-queue-processor
cp env.$UR_DEV .env
npm install
typings install
# npm run-script debug
npm start
