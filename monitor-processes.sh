#!/usr/bin/env bash
# set -x #echo on


GUR=~/Downloads/gur-darwin-10.6-amd64/gur

showQueueStates () {
  queue=$1
  echo
  echo "tasks in $queue:"
  curl -s "https://ur-money-production.firebaseio.com/$queue/tasks.json?auth=GGl4d0BKYzf7b5L50eEHYICCZ3PdfvsuPJi6hW6l" | jq 'if . == null then [] else to_entries end | .[] | .value._state' | sort | uniq -c | tee /tmp/monitor.results.tmp
  [ -s /tmp/monitor.results.tmp ] || echo "  <no tasks found>"
}

startTestGurInstance () {
  echo
  echo "TODO: for testing purposes, we are starting a local instance of gur; this should be removed when we are monitoring on the actual servers"
  nohup $GUR --networkid 1 --datadir $HOME/dev/ur_data.prod --ipcapi='admin,db,ur,debug,miner,net,shh,txpool,personal,web3' --bootnodes enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@138.197.138.155:19595,enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@138.197.138.202:19595 --rpcapi db,personal,ur,eth,net,web3 --rpccorsdomain=* --rpc --rpcaddr=127.0.0.1  </dev/null > $HOME/dev/ur_data.prod/gur.log 2>&1 &
  sleep 5
  $GUR --exec "admin.addPeer('enode://fcf730cf678d6296ffa75a1b2c06aa07d9558788762d0bbefbc209ccbfb4e840f7dcfc2f7a188eb2e65056d989de3722df3fc4df286eb3690d4586992c1c6d82@159.203.14.117:19595'); admin.addPeer('enode://d846b3c0445b7a91cfeb56fbeaece55ca9e559a6e5810cc41c54e2b88790fa7a24444508f16eb983630da1367ab73a6db1b705cc36134d9e61a2df070284d3f4@159.203.36.102:19595');" attach ipc:$HOME/dev/ur_data.prod/gur.ipc
}

getGurPeers () {
  node=$1
  echo "  $1 has the following peers:"
  $GUR --exec "admin.peers;" attach ipc:$HOME/dev/ur_data.prod/gur.ipc | grep "^ *remoteAddress:" | cut -f 2 -d\"
}

runGetBalanceViaRPC () {
  echo "  running ur_getBalance via RPC (TODO: need to run this on the remote machine instead of locally)"
  curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"ur_getBalance\",\"params\":[\"0xde0b295669a9fd93d5f28d9ec85e40f4cb697bae\", \"latest\"],\"id\":1001}" 127.0.0.1:9595
}

echo "starting local instance of gur for testing purposes..."
startTestGurInstance

echo
echo "***BOOTNODE-1"
getGurPeers bootnode-1

echo
echo "***BOOTNODE-2"
getGurPeers bootnode-2

echo
echo "***EXPLORER-1"
getGurPeers explorer-1
echo "  TODO: need to check status of http service on explorer-1: 80"

echo
echo "***MINER-1"
getGurPeers miner-1
echo "  TODO: need to check results of sending ur.mining to rpc service on miner-1"

echo
echo "***TRANSACTION-RELAY-1"
getGurPeers transaction-relay-1
runGetBalanceViaRPC

echo
echo "***IDENTIFIER-1"
getGurPeers transaction-relay-1
runGetBalanceViaRPC

echo
echo "number of users who have signed in and created a wallet:"
curl -s 'https://ur-money-production.firebaseio.com/users.json?auth=GGl4d0BKYzf7b5L50eEHYICCZ3PdfvsuPJi6hW6l&orderBy="wallet/address"&startAt="0"&endAt="z"' | jq 'to_entries| .[] | .key' | wc -l

echo
echo "number users who have started the process of registration (grouped by state):"
curl -s 'https://ur-money-production.firebaseio.com/users.json?auth=GGl4d0BKYzf7b5L50eEHYICCZ3PdfvsuPJi6hW6l&orderBy="registration/status"&startAt="0"&endAt="z"' | jq 'to_entries| .[] | select(.value.registration.status) | .value.registration.status' | sort | uniq -c

echo
echo "number of disabled users:"
curl -s 'https://ur-money-production.firebaseio.com/users.json?auth=GGl4d0BKYzf7b5L50eEHYICCZ3PdfvsuPJi6hW6l&orderBy="disabled"&equalTo="true"' | jq 'to_entries| .[] | .key' | wc -l

echo
echo "number of users locked out because of failed logins:"
curl -s 'https://ur-money-production.firebaseio.com/users.json?auth=GGl4d0BKYzf7b5L50eEHYICCZ3PdfvsuPJi6hW6l&orderBy="failedLoginCount"&startAt=10' | jq 'to_entries| .[] | .key' | wc -l


# queues
showQueueStates smsAuthCodeGenerationQueue
showQueueStates smsAuthCodeMatchingQueue
showQueueStates emailAuthCodeGenerationQueue
showQueueStates emailAuthCodeMatchingQueue
showQueueStates identityAnnouncementQueue
showQueueStates identityVerificationQueue
showQueueStates invitationQueue
showQueueStates phoneLookupQueue
showQueueStates prefineryImportQueue
showQueueStates urTransactionImportQueue
