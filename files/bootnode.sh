#!/bin/bash

. ./gur-options.sh
set -eo pipefail
if [[ "`uname -n`" == "bootnode-1" ]]; then
  NODEKEYHEX=BOOTNODE1_KEYHEYHEX
elif [[ "`uname -n`" == "bootnode-2" ]]; then
  NODEKEYHEX=BOOTNODE2_KEYHEYHEX
fi
gur $BASE_GUR_OPTIONS --nodekeyhex $NODEKEYHEX
