#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail
set -x #echo on

IP1=\"${BOOTNODE_1_PUBLIC_IP}\"
IP2=\"${BOOTNODE_2_PUBLIC_IP}\"
files/gur --exec "admin.addPeer(${IP1}); admin.addPeer(${IP2});" ipc:/home/deploy/ur_data/gur.ipc
