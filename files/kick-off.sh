#!/bin/bash

. files/gur-options.sh
set -eo pipefail
files/gur --exec "loadScript('/home/deploy/files/kick-off.js');" attach ipc:/home/deploy/ur_data/gur.ipc
