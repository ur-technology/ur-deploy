#!/bin/bash

. ./params.sh
set -eo pipefail
gur $COMMON_GUR_OPTIONS attach ipc:/root/ur_data/geth.ipc
