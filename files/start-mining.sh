#!/bin/bash

. files/gur-options.sh
set -eo pipefail
files/gur $BASE_GUR_OPTIONS --exec "miner.setEtherbase('0x007ccffb7916f37f7aeef05e8096ecfbe55afc2f'); miner.start(2);" attach ipc:/home/deploy/ur_data/geth.ipc
