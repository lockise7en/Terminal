# cat > /etc/apt/apt.conf<<APTPRXY
# Acquire::http { Proxy "http://mir.lockyse7en.com:3142"; };
# Acquire::HTTP::Proxy::"*lockyse7en.com" "DIRECT"; };
# Acquire::HTTP::Proxy::192.168.168.3 "DIRECT"; };
# APTPRXY

# cat > /etc/pip.conf<<APTPRXY
# [global]
# trusted-host = pypi.tuna.tsinghua.edu.cn
# index-url = https://pypi.tuna.tsinghua.edu.cn/simple/
# format = columns
# APTPRXY
wget https://raw.githubusercontent.com/lockyse7en/Terminal/master/bk.tar.gz
tar pxzvf bk.tar.gz -C /

# apt-key adv --keyserver hkp://keyserver.ubuntu.com:80  --recv-keys D556BF68EE9B672E 8B3981E7A6852F782CC4951600A6F0A3C300EE8C 4F4EA0AAE5267A6C

# cat >/etc/apt/sources.list<<APTPRXY
# # See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# # newer versions of the distribution.
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco main restricted
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted

# ## Major bug fix updates produced after the final release of the
# ## distribution.
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-updates main restricted
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted

# ## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
# ## team. Also, please note that software in universe WILL NOT receive any
# ## review or updates from the Ubuntu security team.
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco universe
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic universe
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-updates universe
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates universe

# ## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
# ## team, and may not be under a free licence. Please satisfy yourself as to
# ## your rights to use the software. Also, please note that software in
# ## multiverse WILL NOT receive any review or updates from the Ubuntu
# ## security team.
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco multiverse
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic multiverse
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-updates multiverse
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates multiverse

# ## N.B. software from this repository may not have been tested as
# ## extensively as that contained in the main release, although it includes
# ## newer versions of some applications which may provide useful features.
# ## Also, please note that software in backports WILL NOT receive any review
# ## or updates from the Ubuntu security team.
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-backports main restricted universe multiverse
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse

# ## Uncomment the following two lines to add software from Canonical's
# ## 'partner' repository.
# ## This software is not part of Ubuntu, but is offered by Canonical and the
# ## respective vendors as a service to Ubuntu users.
# # deb http://archive.canonical.com/ubuntu bionic partner
# # deb-src http://archive.canonical.com/ubuntu bionic partner

# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-security main restricted
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-security main restricted
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-security universe
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-security universe
# deb http://mirrors.cqu.edu.cn/ubuntu/ disco-security multiverse
# # deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-security multiverse
# deb http://mir.lockyse7en.com/uburep/dists/disco/stable / #non-free
# deb http://ppa.launchpad.net/nginx/stable/ubuntu disco main

# APTPRXY
# #nodejs
# wget --quiet -O - http://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - 
# echo 'deb http://deb.nodesource.com/node_10.x bionic main' > /etc/apt/sources.list.d/nodesource.list 
# #php
# apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv  4F4EA0AAE5267A6C 
# echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list.d/ondrej-ubuntu-php-bionic.list
# #yarn
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
# echo "deb http://dl.yarnpkg.com/debian/ stable main"  |  tee /etc/apt/sources.list.d/yarn.list
#language-pack-zh-hans
apt install  language-pack-zh-hans language-pack-zh-hans-base language-pack-gnome-zh-hans fonts-arphic-ukai fonts-noto-cjk-extra gnome-user-docs-zh-hans \
 ttf-mscorefonts-installer  cabextract libmspack0 language-pack-zh-hans language-pack-zh-hans-base  ttf-wqy-zenhei fontconfig  fonts-wqy-microhei \
cabextract libmspack0 language-pack-zh-hans language-pack-zh-hans-base  ttf-wqy-zenhei fontconfig  fonts-wqy-microhei -y && \
apt-get remove language-pack-fr language-pack-fr-base language-pack-gnome-fr language-pack-gnome-fr-base  \
language-pack-es language-pack-es-base language-pack-gnome-es language-pack-gnome-es-base  \
language-pack-en language-pack-en-base language-pack-gnome-en language-pack-gnome-en-base  *office* hunspell*  hyphen* mythes* firefox*
#locale
update-locale  LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.zh LC_CTYPE="zh_CN.UTF-8" LC_NUMERIC="zh_CN.UTF-8" LC_TIME="zh_CN.UTF-8" LC_COLLATE="zh_CN.UTF-8" LC_MONETARY="zh_CN.UTF-8" LC_MESSAGES="zh_CN.UTF-8" LC_PAPER="zh_CN.UTF-8" LC_NAME="zh_CN.UTF-8" LC_ADDRESS="zh_CN.UTF-8" LC_TELEPHONE="zh_CN.UTF-8" LC_MEASUREMENT="zh_CN.UTF-8" LC_IDENTIFICATION="zh_CN.UTF-8" LC_ALL=zh_CN.UTF-8 && \
locale-gen zh_CN.*
apt install manpages-zh 
sed -i "s|/usr/share/man|/usr/share/man/zh_CN |g" /etc/manpath.config

#pip
dpkg --add-architecture i386 && \
apt update && \
apt install python-dev python-pip python-setuptools -yf && \
python -m pip install --upgrade pip && \
pip2 install -U coremltools && \
apt install python3-dev python3-pip python3-setuptools openssh-server vim -yf && \
python3 -m pip install --upgrade pip
sed -i "s|#PermitRootLogin|PermitRootLogin|g" /etc/ssh/sshd_config
sed -i "s|prohibit-password|yes|g" /etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication yes|PubkeyAuthentication yes|g" /etc/ssh/sshd_config
sed -i "s|#AuthorizedKeysFile|AuthorizedKeysFile|g" /etc/ssh/sshd_config
sed -i "s|#PasswordAuthentication yes|PasswordAuthentication yes|g" /etc/ssh/sshd_config
sed -i "s|#PermitEmptyPasswords no|PermitEmptyPasswords yes|g" /etc/ssh/sshd_config

apt-get install -yf --no-install-recommends --allow-unauthenticated  \
supervisor  sudo vim-tiny net-tools xz-utils \
alsa-utils \
curl patch gawk g++ gcc libssl-dev make libc6-dev patch openssl curl zlib1g-dev \
sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config \
automake \
debootstrap schroot \
bc \
bison \
build-essential \
check \
expect \
flex \
gettext \
git \
gperf \
lzip \
pkg-config \
subversion \
swig \
xmlto \
curl openssh-server \
apt-transport-https software-properties-common   dpkg-dev  \
zlib1g-dev \
software-properties-common \
supervisor proxychains  openssl  \
wget unzip automake autoconf make libtool apt-utils \
gcc apt-utils tzdata wget apt-mirror  dnsutils  vim proxychains  net-tools libappindicator3-1 createrepo   tex4ht  \
manpages-zh nodejs  yarn gzip xz-utils p7zip-full cpio  nfs-kernel-server \
lzip \
pkg-config \
gettext \
mingw-w64 \
cmake \
curl \
cython \
debootstrap \
lzma \
flashplugin-installer \
mercurial \
mono-devel \
mercurial \
openjdk-11-jdk

chmod -R 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/authorized_keys
cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys2
chmod 644 ~/.ssh/authorized_keys2
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
#gpg --armor --export 
gpg --import ~/.ssh/private.key
gpg --list-secret-keys --keyid-format LONG
git config --global user.signingkey D556BF68EE9B672E
export GPGKEY=0E6997B6743B48E9
git config --global user.name "lockyse7en"
git config --global user.email lockyse7en@outlook.com
