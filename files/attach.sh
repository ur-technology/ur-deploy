#!/bin/bash
set -eo pipefail

/root/go-ur/build/bin/gur --networkid 1001 --datadir /root/ur_data --bootnodes="enode://288b97262895b1c7ec61cf314c2e2004407d0a5dc77566877aad1f2a36659c8b698f4b56fd06c4a0c0bf007b4cfb3e7122d907da3b005fa90e724441902eb19e@172.21.0.2:19595" --ipcapi="admin,db,eth,debug,miner,net,shh,txpool,personal,web3" attach ipc:/root/ur_data/geth.ipc
