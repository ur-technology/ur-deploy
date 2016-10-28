#!/bin/bash

files/gur --exec "admin.addPeer('enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@138.197.138.155:19595'); admin.addPeer('enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@138.197.138.202:19595');" attach ipc:/home/deploy/ur_data/gur.ipc

files/gur --exec "console.log('*****************');" attach ipc:/home/deploy/ur_data/gur.ipc
