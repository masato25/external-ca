# Run up Peers.

### Please runup orderer first.
for more details, please check runup_orderer.md, if you already did it,
you will have config folder under the working directory.

```
└[~/external-ca]> tree config
config
|-- channel-artifacts
|   `-- external-ca-channel_Org1MSPanchors.tx
|-- external-ca-channel.tx
`-- genesis.block
```

### Start Peers & required components
```
./scripts/start_peer0.sh
```

### Join peer into channel

please refer single_org_fabric_networking_init_chaincode.md
