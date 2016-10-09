#!/bin/bash


. files/gur-options.sh
set -eo pipefail
EXPLORER_IP_ADDRESS=$(nslookup explorer.ur.technology | awk '/./{line=$0} END{print line}' | awk '{print $2}')
RPC_OPTIONS="--rpc --rpcaddr $EXPLORER_IP_ADDRESS --rpcport 9595 --rpcapi 'web3,eth' --rpccorsdomain 'http://explorer.ur.technology'"
nohup files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION $RPC_OPTIONS" </dev/null > ~/ur_data/gur.log 2>&1 &"

cd explorer
npm install bower
sed -i "s/localhost/$EXPLORER_IP_ADDRESS/g" app/app.js
sed -i 's/localhost/0.0.0.0/g' package.json
npm install
npm start
