# Production Network

## ca:
#### msp:
/etc/hyperledger/fabric-ca-server-config
#### datastore:
/etc/hyperledger/fabric-ca-server

## orderer:
##### msp:
/var/hyperledger/orderer
#### datastore:
/var/hyperledger/production

## peer
#### msp/tls:
/etc/hyperledger/fabric
#### datastore:
/var/hyperledger/production

## couchDB
#### datastore
/opt/couchdb
