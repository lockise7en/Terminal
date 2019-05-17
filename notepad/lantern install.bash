#!/bin/bash
export GO_VERSION go1.4.2
export GOROOT_BOOTSTRAP /go1.4
export GOROOT /go
export GOPATH /

export PATH $PATH:$GOROOT/bin
export WORKDIR /lantern


export GO_PACKAGE_URL https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
#
curl -sSL $GO_PACKAGE_URL | tar -xvz -C /tmp && \
mv /tmp/go $GOROOT_BOOTSTRAP
#
mkdir -p $GOROOT && \
  git clone https://go.googlesource.com/go $GOROOT && \
  cd $GOROOT && \
  git checkout -b go1.4 origin/release-branch.go1.4

#  
cd $GOROOT/ && CGO_ENABLED=1 ./all.bash
  
#  
apt install -y mingw32-gcc.x86_64
#
cd $GOROOT/ && CGO_ENABLED=1 GOOS=linux GOARCH=amd64 ./make.bash --no-clean
#
cd $GOROOT/ && CGO_ENABLED=1 GOOS=linux GOARCH=386 ./make.bash --no-clean
#
cd $GOROOT/ && CXX_FOR_TARGET=i686-w64-mingw32-g++ CC_FOR_TARGET=i686-w64-mingw32-gcc CGO_ENABLED=1 GOOS=windows GOARCH=386 ./make.bash --no-clean
#
cd $GOROOT/ && GOARCH=386 ./make.bash --no-clean
