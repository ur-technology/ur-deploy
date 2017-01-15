#!/bin/bash

echo "here 0"
echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail

nohup ~/files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1" </dev/null > ~/ur_data/gur.log 2>&1 &
sleep 30
echo "here 1"

rm -rf ~/ur-money-queue-processor
cp -R ~/files/ur-money-queue-processor ~/
cd ~/ur-money-queue-processor
if [[ "$UR_ENV" == "production" ]]; then
  cp env.transaction-importer.production .env
else
  cp env.transaction-importer.staging .env
fi
echo "here 2"

npm install
typings install

LOG=~/ur-money-queue-processor/ur-money-queue-processor.log
touch $LOG
nohup npm start </dev/null >> $LOG 2>&1 &
tail -f $LOG
