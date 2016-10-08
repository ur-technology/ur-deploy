#!/bin/bash

. ./gur-options.sh
set -eo pipefail
gur $BASE_GUR_OPTIONS --exec "miner.stop();" attach ipc:/home/deploy/ur_data/geth.ipc
