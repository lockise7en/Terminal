# This docker machine is able to compile and sign Lantern for Linux and
# Windows.

FROM fedora:21
MAINTAINER "The Lantern Team" <team@getlantern.org>

rm -rf /etc/yum.repos.d

COPY yum.repos.d /etc/yum.repos.d

ENV WORKDIR /lantern
ENV SECRETS /secrets

mkdir -p $WORKDIR
mkdir -p $SECRETS

# Updating system.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir deltarpm && yum update --downloadonly  --downloaddir=/share/downloaddir 

# Requisites for building Go.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir git tar gzip curl hostname 

# Compilers and tools for CGO.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir gcc gcc-c++ libgcc.i686 gcc-c++.i686 pkg-config 

# Requisites for bootstrapping.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir glibc-devel glibc-static 
yum reinstall --downloadonly  --downloaddir=/share/downloaddir glibc-devel.i686 glib2-static.i686 glibc-2.20-8.fc21.i686 libgcc.i686 

# Requisites for ARM
# ARM EABI toolchain must be grabbed from an contributor repository, such as:
# https://copr.fedoraproject.org/coprs/lantw44/arm-linux-gnueabi-toolchain/
yum reinstall --downloadonly  --downloaddir=/share/downloaddir yum-utils && \
  rpm --import https://copr-be.cloud.fedoraproject.org/results/lantw44/arm-linux-gnueabi-toolchain/pubkey.gpg && \
  yum-config-manager --add-repo=https://copr.fedoraproject.org/coprs/lantw44/arm-linux-gnueabi-toolchain/repo/fedora-21/lantw44-arm-linux-gnueabi-toolchain-fedora-21.repo && \
  yum reinstall --downloadonly  --downloaddir=/share/downloaddir arm-linux-gnueabi-gcc arm-linux-gnueabi-binutils arm-linux-gnueabi-glibc
  

# Requisites for windows.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir mingw32-gcc.x86_64 

# Requisites for building Lantern on Linux.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir gtk3-devel libappindicator-gtk3 libappindicator-gtk3-devel 
yum reinstall --downloadonly  --downloaddir=/share/downloaddir pango.i686 pango-devel.i686 gtk3-devel.i686 gdk-pixbuf2-devel.i686 cairo-gobject-devel.i686 \
  atk-devel.i686 libappindicator-gtk3-devel.i686 libdbusmenu-devel.i686 dbus-devel.i686 pkgconfig.i686
  

# Requisites for packing Lantern for Debian.
# The fpm packer. (https://rubygems.org/gems/fpm)
yum reinstall --downloadonly  --downloaddir=/share/downloaddir ruby ruby-devel make 
gem reinstall fpm

# Requisites for packing Lantern for Windows.
yum reinstall --downloadonly  --downloaddir=/share/downloaddir osslsigncode mingw32-nsis 

# Required for compressing update files
yum reinstall --downloadonly  --downloaddir=/share/downloaddir bzip2 

# Requisites for genassets.
curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
yum --downloadonly  --downloaddir=/share/downloaddir reinstall nodejs 
npm reinstall -g gulp

# Getting Go.
ENV GOROOT /usr/local/go
ENV GOPATH /

ENV PATH $PATH:$GOROOT/bin

ENV GO_PACKAGE_URL https://s3-eu-west-1.amazonaws.com/uaalto/go1.6.2_lantern_20160503_linux_amd64.tar.gz
curl -sSL $GO_PACKAGE_URL | tar -xvzf - -C /usr/local

# Expect the $WORKDIR volume to be mounted.
VOLUME [ "$WORKDIR" ]

WORKDIR $WORKDIR
