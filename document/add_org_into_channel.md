# 實現增加FirstHolding到現有channel內

* jq reuired

## Generate config
```
configtxgen -profile configtx.yaml -printOrg OrgFTBANKMSP > crypto-config/peerOrganizations/org.firstholding.com/org.json
```

## Featch current block of peer which already joined channel
```
MYCHANNEL=external-ca-channel
mkdir -p /config/channel-artifacts
peer channel fetch config /config/channel-artifacts/config_block.pb -o o1.orderer.tsohue.com:7050 --tls --cafile /var/crypto/ordererOrganizations/orderer.tsohue.com/msp/tlscacerts/tlsca.orderer.tsohue.com-cert.pem -c $MYCHANNEL

configtxlator proto_decode --input /config/channel-artifacts/config_block.pb --type common.Block --output /config/channel-artifacts/config_block.json
jq .data.data[0].payload.data.config /config/channel-artifacts/config_block.json > /config/channel-artifacts/config.json
```

## scp current config to first holding
```
scp -r config tsohue-peer3:~/external-ca
```

## run on new org
```
MYCHANNEL=external-ca-channel
WORKDIR=~/external-ca
cd $WORKDIR
mkdir -p ./config/addOrgFTBANK
jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"OrgFTBANKMSP":.[1]}}}}}' ./config/channel-artifacts/config.json ./crypto-config/peerOrganizations/org.firstholding.com/org.json > ./config/addOrgFTBANK/modified_config.json

configtxlator proto_encode --input ./config/channel-artifacts/config.json --type common.Config --output ./config/channel-artifacts/config.pb
configtxlator proto_encode --input ./config/addOrgFTBANK/modified_config.json --type common.Config --output ./config/addOrgFTBANK/modified_config.pb
configtxlator compute_update --channel_id $MYCHANNEL --original  ./config/channel-artifacts/config.pb --updated ./config/addOrgFTBANK/modified_config.pb --output ./config/addOrgFTBANK/org3_update.pb
configtxlator proto_decode --input ./config/addOrgFTBANK/org3_update.pb --type common.ConfigUpdate --output ./config/addOrgFTBANK/org3_update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"'$MYCHANNEL'", "type":2}},"data":{"config_update":'$(cat ./config/addOrgFTBANK/org3_update.json)'}}}' | jq . > ./config/addOrgFTBANK/org3_update_in_envelope.json
configtxlator proto_encode --input ./config/addOrgFTBANK/org3_update_in_envelope.json --type common.Envelope --output ./config/addOrgFTBANK/org3_update_in_envelope.pb
```

# scp to org1
```
scp -r config tsohue-peer1:~/external-ca
```

# run on org1 docker peer
```
peer channel signconfigtx -f /config/addOrgFTBANK/org3_update_in_envelope.pb

# if you have two org. run this on another org's peer cli
MYCHANNEL=external-ca-channel
peer channel update -f /config/addOrgFTBANK/org3_update_in_envelope.pb -c $MYCHANNEL -o o1.orderer.tsohue.com:7050 --tls --cafile /var/crypto/ordererOrganizations/orderer.tsohue.com/msp/tlscacerts/tlsca.orderer.tsohue.com-cert.pem
```

# run on org3 docker peer
```
# mkdir -p /config/addOrgFTBANK/
MYCHANNEL=external-ca-channel
peer channel fetch 0 /config/addOrgFTBANK/$MYCHANNEL.block -o o1.orderer.tsohue.com:7050  -c $MYCHANNEL --tls --cafile /var/crypto/ordererOrganizations/orderer.tsohue.com/msp/tlscacerts/tlsca.orderer.tsohue.com-cert.pem
peer channel join -b /config/addOrgFTBANK/$MYCHANNEL.block
```
