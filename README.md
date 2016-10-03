# UR Deployment

To run an UR Docker cluster run the following:

```
docker-compose up -d
```

By default this will create:

* 1 UR bootnode container
* 1 UR transaction relay container (which connects to the bootnode containers)
* 1 UR miner container (which connect to the bootnode containers)

To access the transaction relay container:

```
PORT_MAPPING=$(docker port urdeploy_transaction-relay_1 9595)
PORT=${PORT_MAPPING##*:}
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1001}' localhost:$PORT
```

##### Scaling the number of nodes/containers in the cluster

```
docker-compose scale miner=3
```

Will scale the number of miner nodes upwards (replace 3 with however many nodes
you prefer). These nodes will connect to the P2P network (via the bootnode nodes)
by default.

#### TODO:

* add UR block explorer container (built on top of gur-client image)
* switch networkid to 1
* download release of gur from github

* install google container engine GKE
* deploy deis helm
deis create ur-money --no-remote
deis pull gcr.io/google-project-id/gur-client:latest -a  ur-money


#### Coming Soon

* 1 UR netstats container (with a Web UI to view activity in the cluster)
* * To access the UR netstats Web UI: `open http://$(docker-machine ip default):3000`
