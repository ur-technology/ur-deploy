#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail
set -x #echo on

GUR=~/Downloads/gur-darwin-10.6-amd64/gur

$GUR --exec "admin.addPeer(\'${BOOTNODE_1_PUBLIC_IP}\'); admin.addPeer(\'${BOOTNODE_2_PUBLIC_IP}\');" ipc:/home/deploy/ur_data/gur.ipc
