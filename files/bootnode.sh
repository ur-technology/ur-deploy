#!/bin/bash

. files/gur-options.sh
set -eo pipefail

BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')

if [[ "$BASE_HOSTNAME" == "bootnode-1" ]]; then
  NODEKEYHEX=$BOOTNODE_1_NODEKEYHEX
elif [[ "$BASE_HOSTNAME" == "bootnode-2" ]]; then
  NODEKEYHEX=$BOOTNODE_2_NODEKEYHEX
elif [[ "$BASE_HOSTNAME" == "bootnode-3" ]]; then
  NODEKEYHEX=$BOOTNODE_3_NODEKEYHEX
else
  echo "ERROR - UNEXPECTED BOOTNODE $BASE_HOSTNAME"
fi

touch ~/ur_data/gur.log
# nohup ~/files/gur $BASE_GUR_OPTIONS --nodekeyhex $NODEKEYHEX </dev/null >> ~/ur_data/gur.log 2>&1 &
# nohup ~/files/gur $BASE_GUR_OPTIONS --nodekeyhex $NODEKEYHEX --nodiscover --maxpeers 5 </dev/null >> ~/ur_data/gur.log 2>&1 &
tail -f ~/ur_data/gur.log
