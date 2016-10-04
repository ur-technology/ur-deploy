#!/usr/bin/env bash

BOOTNODE1_IP_ADDRESS=$(grep bootnode1 /etc/hosts | awk '{print $1}')
BOOTNODE2_IP_ADDRESS=$(grep bootnode2 /etc/hosts | awk '{print $1}')
BOOTNODE1_ENODE_URL="enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@$BOOTNODE1_IP_ADDRESS:19595"
BOOTNODE2_ENODE_URL="enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@$BOOTNODE2_IP_ADDRESS:19595"

if [[ "`uname -n`" != *bootnode* ]]; then
  BOOTNODES_OPTION="--bootnodes ${BOOTNODE1_ENODE_URL},${BOOTNODE2_ENODE_URL}"
fi
export BASE_GUR_OPTIONS="$BOOTNODES_OPTION --networkid 1001 --datadir /home/deploy/ur_data --ipcapi='admin,db,eth,debug,miner,net,shh,txpool,personal,web3'"

export BOOTNODE1_NODEKEYHEX="4b3698f291fe0c9db2de3cbe98f0cf01a4446b1accf1c69cfccb80ee241d8099"
export BOOTNODE2_NODEKEYHEX="78fd2bf45c4e09d7102a95fb9529876d05d2088cd37a4455b19d2507b0a88cb1"
