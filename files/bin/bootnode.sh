#!/bin/bash

. bin/gur-options.sh
set -eo pipefail
if [[ "`uname -n`" == "bootnode-1" ]]; then
  NODEKEYHEX=$BOOTNODE1_NODEKEYHEX
elif [[ "`uname -n`" == "bootnode-2" ]]; then
  NODEKEYHEX=$BOOTNODE2_NODEKEYHEX
else
  NODEKEYHEX=$BOOTNODE2_NODEKEYHEX
  echo "ERROR - UNEXPECTED BOOTNODE `uname -n`"
fi
bin/gur $BASE_GUR_OPTIONS --nodekeyhex $NODEKEYHEX
