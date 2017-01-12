#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "production" ]]; then
  BOOTNODE_1_PUBLIC_IP=159.203.44.174
  BOOTNODE_2_PUBLIC_IP=138.197.143.33
  NETWORK_ID=1
elif [[ "$UR_ENV" == "staging" ]]; then
  BOOTNODE_1_PUBLIC_IP=138.197.138.155
  BOOTNODE_2_PUBLIC_IP=138.197.138.202
  NETWORK_ID=1004
else
  echo "Usage: $0 production|staging"
  exit 1
fi

. files/gur-options.sh

GUR=~/Downloads/gur-darwin-10.6-amd64

mkdir -p $HOME/dev/ur_data.${UR_ENV}
touch $HOME/dev/ur_data.${UR_ENV}/gur.log
nohup ${GUR} --networkid ${NETWORK_ID} --datadir $HOME/dev/ur_data.${UR_ENV} --ipcapi="admin,db,ur,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,personal,ur,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr=127.0.0.1 </dev/null > $HOME/dev/ur_data.${UR_ENV}/gur.log 2>&1 &
sleep 10
${GUR} attach ipc:$HOME/dev/ur_data.${UR_ENV}/gur.ipc
