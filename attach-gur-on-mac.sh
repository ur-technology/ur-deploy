#!/usr/bin/env bash

UR_ENV=$1
if [[ "$UR_ENV" == "production" ]]; then
  echo "production"
elif [[ "$UR_ENV" == "staging" ]]; then
  echo "staging"
else
  echo "Usage: $0 production|staging"
  exit 1
fi

GUR=~/Downloads/gur-darwin-10.6-amd64

${GUR} attach ipc:$HOME/dev/ur_data.${UR_ENV}/gur.ipc
