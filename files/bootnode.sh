#!/bin/bash

. files/gur-options.sh
set -eo pipefail

BASE_HOSTNAME=$(echo $(hostname) | sed -e 's/^dev\-//')

if [[ "$BASE_HOSTNAME" == "bootnode-1" ]]; then
  NODEKEYHEX=$BOOTNODE_1_NODEKEYHEX
elif [[ "$BASE_HOSTNAME" == "bootnode-2" ]]; then
  NODEKEYHEX=$BOOTNODE_2_NODEKEYHEX
else
  NODEKEYHEX=$BOOTNODE_2_NODEKEYHEX
  echo "ERROR - UNEXPECTED BOOTNODE $BASE_HOSTNAME"
fi
files/gur $BASE_GUR_OPTIONS --nodekeyhex $NODEKEYHEX
