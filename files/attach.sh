#!/bin/bash

. ./gur-options.sh
set -eo pipefail
gur $BASE_GUR_OPTIONS attach ipc:/home/deploy/ur_data/geth.ipc
