#!/bin/bash

TRANSACTION_RELAY_IP_ADDRESS=$(nslookup rpc-1.ur.technology | awk '/./{line=$0} END{print line}' | awk '{print $2}')
echo "TRANSACTION_RELAY_IP_ADDRESS=$TRANSACTION_RELAY_IP_ADDRESS"
set -eo pipefail
cd explorer
npm install bower
sed -i "s/localhost/$TRANSACTION_RELAY_IP_ADDRESS/g" app/app.js
sed -i 's/localhost/0.0.0.0/g' package.json
echo "2 ******************************"
grep start package.json
npm install
npm start
