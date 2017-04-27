#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail

rm -rf ~/ur-money-queue-processor
cp -R ~/files/ur-money-queue-processor ~/
mkdir -p ~/ur_data/keystore
if [[ "$UR_ENV" == "production" ]]; then
  cp ~/files/keystore.production/* ~/ur_data/keystore/
else
  cp ~/files/keystore.staging/* ~/ur_data/keystore/
fi

nohup ~/files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1" </dev/null > ~/ur_data/gur.log 2>&1 &
sleep 60

cd ~/ur-money-queue-processor
if [[ "$UR_ENV" == "production" ]]; then
  cp env.identifier.production .env
else
  cp env.combined.staging .env
fi

PRIVILEGED_UTI_OUTBOUND_PASSWORD=$(echo $PRIVILEGED_UTI_OUTBOUND_PASSWORD | sed -e 's/\-/ /g')
echo "PRIVILEGED_UTI_OUTBOUND_PASSWORD=$PRIVILEGED_UTI_OUTBOUND_PASSWORD" >> .env

npm install
typings install

LOG=~/ur-money-queue-processor/ur-money-queue-processor.log
touch $LOG
nohup npm start </dev/null >> $LOG 2>&1 &
tail -f $LOG
