#!/bin/bash
set -eo pipefail

/root/go-ur/build/bin/gur --networkid 1001 --datadir /root/ur_data --bootnodes="enode://288b97262895b1c7ec61cf314c2e2004407d0a5dc77566877aad1f2a36659c8b698f4b56fd06c4a0c0bf007b4cfb3e7122d907da3b005fa90e724441902eb19e@bootnode-1:19595" --ipcapi="admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,personal,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="0.0.0.0" --mine --minerthreads=8 --etherbase="0x007ccffb7916f37f7aeef05e8096ecfbe55afc2f"
