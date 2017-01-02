#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "production" ]]; then
  echo "running $0 in production mode"
  NETWORK_ID=1
  BOOTNODE_1="'enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@159.203.14.117:19595'";
  BOOTNODE_2="'enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@159.203.36.102:19595'";
elif [[ "$UR_ENV" == "staging" ]]; then
  echo "running $0 in staging mode"
  NETWORK_ID=1004
  BOOTNODE_1="'enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@138.197.138.155:19595'";
  BOOTNODE_2="'enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@138.197.138.202:19595'";
else
  echo "Usage: $0 production|staging"
  exit 1
fi

GUR=~/Downloads/gur-darwin-10.6-amd64

nohup ${GUR} --networkid ${NETWORK_ID} --datadir $HOME/dev/ur_data.${UR_ENV} --ipcapi='admin,db,ur,debug,miner,net,shh,txpool,personal,web3' --bootnodes enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@138.197.138.155:19595,enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@138.197.138.202:19595 --rpcapi db,personal,ur,eth,net,web3 --rpccorsdomain=* --rpc --rpcaddr=127.0.0.1 </dev/null > $HOME/dev/ur_data.${UR_ENV}/gur.log 2>&1 & 
sleep 10
${GUR} --exec "admin.addPeer(${BOOTNODE_1}); admin.addPeer(${BOOTNODE_2});" attach ipc:$HOME/dev/ur_data.${UR_ENV}/gur.ipc
sleep 10
${GUR} attach ipc:$HOME/dev/ur_data.${UR_ENV}/gur.ipc
