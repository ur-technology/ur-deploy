#!/bin/bash


. files/gur-options.sh
set -eo pipefail
nohup files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="0.0.0.0" </dev/null > ~/ur_data/gur.log 2>&1 &

cd explorer
npm install bower
EXPLORER_IP_ADDRESS=$(nslookup explorer.ur.technology | awk '/./{line=$0} END{print line}' | awk '{print $2}')
sed -i "s/localhost/$EXPLORER_IP_ADDRESS/g" app/app.js
sed -i 's/localhost/0.0.0.0/g' package.json
npm install
npm start
