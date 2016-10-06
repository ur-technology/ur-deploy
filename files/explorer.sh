#!/bin/bash


. ./gur-options.sh
set -eo pipefail
nohup gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="0.0.0.0" </dev/null > ~/ur_data/gur.log 2>&1 &

PUBLIC_IP_ADDRESS=$(nslookup explorer.ur.technology | awk '/./{line=$0} END{print line}' | awk '{print $2}')
echo "PUBLIC_IP_ADDRESS=$PUBLIC_IP_ADDRESS"
set -eo pipefail
cd explorer
npm install bower
sed -i "s/localhost/$PUBLIC_IP_ADDRESS/g" app/app.js
sed -i 's/localhost/0.0.0.0/g' package.json
echo "2 ******************************"
grep start package.json
npm install
npm start
