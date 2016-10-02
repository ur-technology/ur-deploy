#!/bin/bash

. ./params.sh
set -eo pipefail
gur ${BASE_GUR_OPTIONS} --nodekeyhex ${BOOTNODE1_NODEKEYHEX}
