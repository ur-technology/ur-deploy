#!/bin/bash

TRANSACTION_RELAY_IP_ADDRESS=$(grep transaction-relay-1 /etc/hosts | awk '{print $1}')
echo "TRANSACTION_RELAY_IP_ADDRESS=$TRANSACTION_RELAY_IP_ADDRESS"
set -eo pipefail
cd explorer
npm install bower
# TODO: figure out how to get this to work when deployed
# sed -i "s/localhost/$TRANSACTION_RELAY_IP_ADDRESS/g" app/app.js
sed -i 's/localhost/0.0.0.0/g' package.json
echo "2 ******************************"
grep start package.json
npm install
npm start
