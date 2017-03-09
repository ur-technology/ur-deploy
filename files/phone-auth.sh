#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

set -eo pipefail

rm -rf ~/ur-money-queue-processor
cp -R ~/files/ur-money-queue-processor ~/
cd ~/ur-money-queue-processor
if [[ "$UR_ENV" == "production" ]]; then
  cp env.auth.production .env
else
  cp env.auth.staging .env
fi

npm install
typings install

LOG=~/ur-money-queue-processor/ur-money-queue-processor.log
touch $LOG
nohup npm start </dev/null >> $LOG 2>&1 &
tail -f $LOG
