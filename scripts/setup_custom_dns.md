# Setup up custom domain name server

### install go first
(How To Install Go 1.15 on Ubuntu 18.04 & 16.04 LTS)[https://tecadmin.net/install-go-on-ubuntu/]

### fetch custom dns program & compile
go get github.com/masato25/go-wild-dns
cd $GOPATH/src/github.com/masato25/go-wild-dns && go build .

### modify settings
cp conf.yaml.example conf.yaml
