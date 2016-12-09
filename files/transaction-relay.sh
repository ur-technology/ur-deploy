#!/bin/bash

. files/gur-options.sh
set -eo pipefail

rm -rf ~/gur-https-proxy
cp -R ~/files/gur-https-proxy ~/

nohup ~/files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="0.0.0.0" </dev/null > ~/ur_data/gur.log 2>&1 &
sleep 60

cd ~/gur-https-proxy
npm install
typings install
if [[ "$UR_ENV" == "production" ]]; then
  cp env.production .env
else
  cp env.staging .env
fi
# npm run-script debug
touch ~/gur-https-proxy.log
nohup npm start </dev/null >> ~/gur-https-proxy.log 2>&1 &
tail -f ~/gur-https-proxy.log
