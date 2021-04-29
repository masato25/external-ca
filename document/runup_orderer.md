## Run up Orderer.

### Modify & check configtx

make sure configtx.yaml settings are all done right. if you want initialize with two organization. please refer configtx_two_org.yaml. please also check all certificate are ready to the place.

### Genereate Default Channel & Genesis blocks

```
./scripts/create_blocks.sh
```
