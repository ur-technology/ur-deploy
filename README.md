# UR Deployment

To run an UR Docker cluster run the following:

```
docker-compose up -d
```

By default this will create:

* 2 UR bootnode containers
* 1 UR transaction relay container (which connects to the bootnode containers)
* 2 UR miner containers (which connect to the bootnode containers)
* 1 UR block explorer container (with a Web UI to view activity in the cluster)
* 1 UR netstats container (with a Web UI to view activity in the cluster)

To access the transaction relay container:

```
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1001}' localhost:9595
```

To access the block explorer Web UI:

```
open http://$(docker-machine ip default):3000
```

To access the netstats Web UI:

```
open http://$(docker-machine ip default):3000
```

##### Scaling the number of nodes/containers in the cluster

```
docker-compose scale miner=3
```

Will scale the number of miner nodes upwards (replace 3 with however many nodes
you prefer). These nodes will connect to the P2P network (via the bootnode nodes)
by default.

#### Test accounts ready for use

As part of the bootstrapping process we bootstrap 10 Ethereum accounts for use
pre-filled with 20 Ether for use in transactions by default.

If you want to change the amount of Ether for those accounts
See ```files/genesis.json```.
