#!/bin/bash

. ./params.sh
set -eo pipefail
gur $COMMON_GUR_OPTIONS --rpcapi "db,personal,eth,net,web3" --rpccorsdomain="*" --rpc --rpcaddr="0.0.0.0"
