# Generate orderer certificates

## Generate Root Keys wit openssl
```
./scripts/create_orderer.sh
```

## Fetch CA & TLS with fabric CA component.
```
./scripts/create_orderer2.sh
```

## Keep fabric ca database
Please mount external disk on /etc/hyperledger/fabric-ca-server
