#!/bin/bash

. files/gur-options.sh
set -eo pipefail
files/gur $BASE_GUR_OPTIONS $BOOTNODES_OPTION --rpcapi "db,personal,ur,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="127.0.0.1"
