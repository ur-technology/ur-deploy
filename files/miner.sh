#!/bin/bash

. ./params.sh
set -eo pipefail
gur $COMMON_GUR_OPTIONS --mine --minerthreads=2 --etherbase="0x007ccffb7916f37f7aeef05e8096ecfbe55afc2f"
