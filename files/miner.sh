#!/bin/bash

. files/gur-options.sh
set -eo pipefail
files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1"
sleep 10
files/gur --exec "admin.addPeer('${BOOTNODE1_ENODE_URL}');admin.addPeer('${BOOTNODE2_ENODE_URL}');" attach ipc:/home/deploy/ur_data/gur.ipc
sleep 10
files/gur --exec "miner.setEtherbase('0x007ccffb7916f37f7aeef05e8096ecfbe55afc2f'); miner.start(4);" attach ipc:/home/deploy/ur_data/gur.ipc
