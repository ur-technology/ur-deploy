#!/bin/bash
set -eo pipefail

/root/go-ur/build/bin/gur --networkid 1001 --datadir /root/ur_data --nodekeyhex=091bd6067cb4612df85d9c1ff85cc47f259ced4d4cd99816b14f35650f59c322 --ipcapi="admin,db,eth,debug,miner,net,shh,txpool,personal,web3"
