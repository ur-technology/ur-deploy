#!/bin/bash


. ./gur-options.sh
set -eo pipefail
nohup gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1" </dev/null > ~/ur_data/gur.log 2>&1 &

cd ur-money-queue-processor
cp staging.env .env

npm install
typings install
npm start
