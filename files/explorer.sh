#!/bin/bash

. ./params.sh
set -eo pipefail
gur $COMMON_GUR_OPTIONS --rpcapi "eth,web3" --rpccorsdomain="http://localhost:8000" --rpc --rpcaddr=localhost &

cd explorer; npm start
