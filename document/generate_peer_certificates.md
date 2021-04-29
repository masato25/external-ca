# Generate peer certificates

## Generate Root Keys wit openssl
```
./scripts/create_peer.sh
```

## Fetch CA & TLS with fabric CA component.
```
./scripts/create_peer2.sh
```

## Keep fabric ca database
Please mount external disk on /etc/hyperledger/fabric-ca-server
