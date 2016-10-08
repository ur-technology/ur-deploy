#!/bin/bash


. files/gur-options.sh
set -eo pipefail
echo "pwd=`pwd`"
echo "ls -l=`ls -l`"
nohup gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1" </dev/null > ~/ur_data/gur.log 2>&1 &

cp -R files/ur-money-queue-processor ~
cd ur-money-queue-processor
cp staging.env .env

npm install
npm install typings
# typings install
# npm start
/bin/bash
