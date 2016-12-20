#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail

if [[ "$UR_ENV" == "production" ]]; then
  echo "running $0 in production mode"
  BOOTNODE_1="'enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@159.203.14.117:19595'";
  BOOTNODE_2="'enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@159.203.36.102:19595'";
elif [[ "$UR_ENV" == "staging" ]]; then
  echo "running $0 in staging mode"
  BOOTNODE_1="'enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@138.197.138.155:19595'";
  BOOTNODE_2="'enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@138.197.138.202:19595'";
else
  echo "Usage: $0 production|staging"
  exit 1
fi

files/gur $BASE_GUR_OPTIONS --exec "admin.addPeer(${BOOTNODE_1}); admin.addPeer(${BOOTNODE_2});" ipc:/home/deploy/ur_data/gur.ipc
