#!/bin/bash


. files/gur-options.sh
set -eo pipefail
nohup files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="0.0.0.0" </dev/null > ~/ur_data/gur.log 2>&1 &

cd explorer
npm install bower
sed -i "s/localhost/$EXPLORER_1_PUBLIC_IP/g" app/app.js
sed -i 's/localhost/0.0.0.0/g' package.json
npm install
npm start
