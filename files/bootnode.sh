#!/bin/bash

. files/gur-options.sh
set -eo pipefail

BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')

if [[ "$BASE_HOSTNAME" == "bootnode-1a" ]]; then
  NODEKEYHEX=$BOOTNODE_1_NODEKEYHEX
elif [[ "$BASE_HOSTNAME" == "bootnode-2a" ]]; then
  NODEKEYHEX=$BOOTNODE_2_NODEKEYHEX
else
  echo "ERROR - UNEXPECTED BOOTNODE $BASE_HOSTNAME"
  exit 1
fi

touch ~/ur_data/gur.log
nohup ~/files/gur $BASE_GUR_OPTIONS --nodekeyhex $NODEKEYHEX </dev/null >> ~/ur_data/gur.log 2>&1 &
# nohup ~/files/kick-off.sh > ~/kick-off.log 2>&1 &
tail -f ~/ur_data/gur.log
