#!/bin/bash

echo "in $0: UR_ENV=$UR_ENV"

. files/gur-options.sh
set -eo pipefail

rm -rf ~/ur-money-queue-processor
cp -R ~/files/ur-money-queue-processor ~/
cd ~/ur-money-queue-processor
if [[ "$UR_ENV" == "production" ]]; then
  cp env.production .env
else
  cp env.staging .env
fi
PRIVILEGED_UTI_OUTBOUND_PASSWORD=$(echo $PRIVILEGED_UTI_OUTBOUND_PASSWORD | sed -e 's/\-/ /g')
echo "PRIVILEGED_UTI_OUTBOUND_PASSWORD=$PRIVILEGED_UTI_OUTBOUND_PASSWORD" >> .env
npm install
typings install
# npm run-script debug
touch ~/ur-money-queue-processor.log
nohup npm start </dev/null >> ~/ur-money-queue-processor.log 2>&1 &
tail -f ~/ur-money-queue-processor.log
