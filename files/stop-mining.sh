#!/bin/bash

. files/gur-options.sh
set -eo pipefail
files/gur $BASE_GUR_OPTIONS --exec "miner.stop();" attach ipc:/home/deploy/ur_data/geth.ipc
