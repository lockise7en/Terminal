cat > /etc/apt/apt.conf<<APTPRXY
Acquire::http { Proxy "http://192.168.168.3:3142"; };
Acquire::http::Proxy { *.lockyse7en.com DIRECT; };
APTPRXY

mirrors.ustc.edu.cn
sed -i "s|cn.archive.ubuntu.com|mirrors.cqu.edu.cn|g" /etc/apt/cat > /etc/apt/apt.conf<<APTPRXY
Acquire::http { Proxy "http://192.168.168.3:3142"; };
Acquire::http::Proxy { *.lockyse7en.com DIRECT; };
APTPRXY
sed -i "s|us.archive.ubuntu.com|mirrors.cqu.edu.cn|g" /etc/apt/sources.list
sed -i "s|us.mirrors.ustc.edu.cn|mirrors.cqu.edu.cn|g" /etc/apt/sources.list
sed -i "s|archive.ubuntu.com|mirrors.cqu.edu.cn|g" /etc/apt/sources.list
sed -i "s|security.ubuntu.com|mirrors.cqu.edu.cn|g" /etc/apt/sources.list

sed -i "s|archive.ubuntu.com|mirrors.ustc.edu.cn|g" /etc/apt/sources.list
sed -i "s|security.ubuntu.com|mirrors.ustc.edu.cn|g" /etc/apt/sources.list

sed -i "s|https|http|g" /etc/apt/sources.list

apt install openssh-server -y -f 
sed -i "s|#Port 22|Port 10022|g" /etc/ssh/sshd_config
sed -i "s|#PermitRootLogin|PermitRootLogin|g" /etc/ssh/sshd_config
sed -i "s|prohibit-password|yes|g" /etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication yes|PubkeyAuthentication yes|g" /etc/ssh/sshd_config
sed -i "s|#AuthorizedKeysFile|AuthorizedKeysFile|g" /etc/ssh/sshd_config
/etc/init.d/ssh restart
chmod -R 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/authorized_keys
#cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys2
chmod 644 ~/.ssh/authorized_keys2
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
#gpg --armor --export 
gpg --import ~/.ssh/private.key

sed -i "s|#PermitRootLogin|PermitRootLogin|g" /usr/local/etc/ssh/sshd_config
sed -i "s|prohibit-password|yes|g" /usr/local/etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication yes|PubkeyAuthentication yes|g" /usr/local/etc/ssh/sshd_config
sed -i "s|#AuthorizedKeysFile|AuthorizedKeysFile|g" /usr/local/etc/ssh/sshd_config

apt-add-repository -y ppa:rael-gc/rvm
 curl -sSL https://rvm.io/mpapis.asc | gpg --import -
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80  --recv-keys A874136B215467E8  8094BB14F4E3FBBE  3B1510FD D259B7555E1D3C58  409B6B1796C275462A1703113804BB82D39DC0E3 E1DD270288B4E6030699E45FA1715D88E1DF1F24  80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 8B3981E7A6852F782CC4951600A6F0A3C300EE8C  4F4EA0AAE5267A6C 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB  D259B7555E1D3C58
  
  

apt install openssh-server -y -f 
sed -i "s|#PermitRootLogin|PermitRootLogin|g" /etc/ssh/sshd_config
sed -i "s|prohibit-password|yes|g" /etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication yes|PubkeyAuthentication yes|g" /etc/ssh/sshd_config
sed -i "s|#AuthorizedKeysFile|AuthorizedKeysFile|g" /etc/ssh/sshd_config
/etc/init.d/ssh restart

AuthorizedKeysFile
#PubkeyAuthentication yes

cdn-fastly.mirrors.ustc.edu.cn
security-cdn.debian.org
deb 'file:///media/fengshun/Ubuntu 16.04.5 LTS _bionic Xerus_ - Release amd64 (20180731)]/ bionic main restricted bionic main restricted'
Acquire::http::Proxy { deb.nodesource.com DIRECT; };
echo 'Acquire::http::Proxy { "http://192.168.168.3:3142"; };' >> /etc/yum.conf
sed -i 's/mirrors.cqu.edu.cn/mir.lockyse7en.com/g' /etc/apt/sources.list
cat >>/etc/apt/apt.conf.d/01proxy<<END
Acquire::http::Proxy { "http://192.168.168.3:3142"; };
END
cat >>/etc/apt/apt.conf.d/01proxy<<END
Acquire::http::Proxy { "http://localhost:3142"; };
END
cat >>/etc/apt/apt.conf.d/01proxy<<END
Acquire::http::Proxy { "http://192.168.168.5:3142"; };
END
Acquire::http::Proxy { 172.17.0.0 DIRECT; };
echo 'Acquire::HTTP::Proxy "http://127.0.0.1:3142/ubuntu";' >> /etc/apt/apt.conf.d/01proxy
cat >>/etc/apt/sources.list.d/host.list<<END
deb file:///mirror/archive.ubuntu.com/ubuntu bionic main restricted universe multiverse
END
mv /etc/apt/sources.list /etc/apt/sources.listbk
echo 'Acquire::HTTP::Proxy "http://192.168.168.3:3143";' >> /etc/apt/apt.conf.d/01proxy
 echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3143";' >> /etc/apt/apt.conf.d/01proxy
 echo 'Acquire::HTTP::Proxy "http://172.17.0.3:3142";' >> /etc/apt/apt.conf.d/01proxy
 
echo "Acquire::http { Proxy"http://192.168.168.3:3142\"; };\nAcquire::HTTP::Proxy::deb.nodesource.com"DIRECT\";" > /etc/apt/apt.conf.d/01proxy 

 echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy
  echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy
add-apt-repository ppa:nginx/stable
mv   /etc/apt/sources.list /etc/apt/sources.listbk
mv  /etc/apt/sources.list.d sources.list.d 
mkdir /etc/apt/sources.list.d
mv /etc/apt/sources.list /etc/apt/sources.listbk
 cat  >>/etc/apt/sources.list<<END
deb http://mirrors.cqu.edu.cn/ubuntu trusty main restricted universe multiverse
# deb- http://mirrors.cqu.edu.cn/ubuntu trusty main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu trusty-updates main restricted universe multiverse
# deb- http://mirrors.cqu.edu.cn/ubuntu trusty-updates main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu trusty-backports main restricted universe multiverse
# deb- http://mirrors.cqu.edu.cn/ubuntu trusty-backports main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu trusty-security main restricted universe multiverse
# deb- http://mirrors.cqu.edu.cn/ubuntu trusty-security main restricted universe multiverse
END
cat  >>/etc/apt/sources.list<<END
deb http://apt.saurik.com/ ios/1145.15 main
deb http://apt.feng.com/ ./
deb http://sextube-iphone.com/ ./
deb http://apt.thebigboss.org/repofiles/cydia/ stable main
deb http://repo.xarold.com/ ./
deb http://apt.abcydia.com/ ./
deb http://apt.modmyi.com/ stable main
deb http://julio.xarold.com/ ./
END
cat  > /etc/apt/apt.conf.d/01proxy<<END
Acquire::http {
Proxy"http://192.168.168.3:3142";
Proxy"http://172.17.0.1:3142";
Proxy"http://lockyse7en.myds.me:3142"
}
END
cat  > /etc/apt/apt.conf.d/01proxy<<END
Acquire::http {Proxy "http://172.17.0.1:3142"}
END

rm -rf  /etc/apt/sources.list
cat  > /etc/apt/sources.list <<END
deb http://mirrors.cqu.edu.cn/debian/ jessie main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian/ jessie main contrib non-free
deb http://mirrors.cqu.edu.cn/debian/ jessie-updates main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian/ jessie-updates main contrib non-free
deb http://mirrors.cqu.edu.cn/debian/ jessie-backports main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian/ jessie-backports main contrib non-free
deb http://mirrors.cqu.edu.cn/debian-security/ jessie/updates main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian-security/ jessie/updates main contrib non-free
END
cat  > /etc/apt/sources.list <<END
deb http://mirrors.cqu.edu.cn/debian/ stretch main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian/ stretch main contrib non-free
deb http://mirrors.cqu.edu.cn/debian/ stretch-updates main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian/ stretch-updates main contrib non-free
deb http://mirrors.cqu.edu.cn/debian/ stretch-backports main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian/ stretch-backports main contrib non-free
deb http://mirrors.cqu.edu.cn/debian-security/ stretch/updates main contrib non-free
#deb- http://mirrors.cqu.edu.cn/debian-security/ stretch/updates main contrib non-free
END
cat  > /etc/apt/apt.conf.d/01proxy<<END
Acquire::http {Proxy"http://192.168.168.3:3142"}
END
cat  >>/etc/apt/apt.conf<<END
Acquire::http {Proxy"http://192.168.168.3:8787"};
Acquire::https {Proxy"https://192.168.168.3:8787"}
END
add-apt-repository 

   "deb [arch=amd64] https://mirrors.cqu.edu.cn/docker-ce/linux/ubuntu 

   $(lsb_release -cs) 

   stable"
   
deb http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main
deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu bionic main
deb http://mirrors.cqu.edu.cn/nginx/stable/ubuntu bionic main
wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo 'deb https://mirrors.cqu.edu.cn/nodesource/deb/node_8.x bionic main' > /etc/apt/sources.list.d/nodesource.list
deb https://mirrors.cqu.edu.cn/nodesource/deb/node_8.x bionic
deb http://mirrors.cqu.edu.cn/postgresql/repos/apt/
deb https://dl.yarnpkg.com/debian/ stable main
  ppa.launchpad.net/rael-gc/rvm/ubuntu 
mirrors.cqu.edu.cn
mv   /etc/apt/sources.list /etc/apt/sources.listbk
cat  >>/etc/apt/sources.list<<END
deb http://mir.lockyse7en.com/ubuntu bionic main restricted universe multiverse
deb-src http://mirrors.cqu.edu.cn/ubuntu bionic main restricted universe multiverse
deb http://mir.lockyse7en.com/ubuntu bionic-updates main restricted universe multiverse
deb-src http://mir.lockyse7en.com/ubuntu bionic-updates main restricted universe multiverse
deb http://mir.lockyse7en.com/ubuntu bionic-backports main restricted universe multiverse
deb-src http://mir.lockyse7en.com/ubuntu bionic-backports main restricted universe multiverse
deb http://mir.lockyse7en.com/ubuntu bionic-security main restricted universe multiverse
deb-src http://mir.lockyse7en.com/ubuntu bionic-security main restricted universe multiverse
END
cat  >>/etc/apt/apt.conf.d/01proxy<<END
Acquire::http {Proxy"http://192.168.168.3:3142"}
END
cat  >>/etc/apt/apt.conf.d/01proxy <<END
Acquire::http {Proxy"http://172.17.0.1:3142"}
END
cat  >>/etc/apt/sources.list<<END
deb http://archive.ubuntu.com/ubuntu bionic main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu bionic-proposed main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu bionic main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu bionic-proposed main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
END


RUN rm -rf  /etc/apt/sources.list
echo 'echo "deb http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted universe multiverse' > /etc/apt/sources.list
 echo '# deb- http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted universe multiverse' > /etc/apt/sources.list
 echo 'deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse' > /etc/apt/sources.list
 echo '# deb- http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse' > /etc/apt/sources.list
 echo 'deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse' > /etc/apt/sources.list
 echo '# deb- http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse' > /etc/apt/sources.list
 echo 'deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-security main restricted universe multiverse' > /etc/apt/sources.list
 echo 'Acquire::http {Proxy"http://192.168.168.3:3142"}' > /etc/apt/apt.conf.d/01proxy
 echo 'check-certificate = off' > /etc/wgetrc
 echo 'https_proxy = http://192.168.168.3:8787/' > /etc/wgetrc
 echo 'http_proxy = http://192.168.168.3:8787/' > /etc/wgetrc
 echo 'ftp_proxy = http://192.168.168.3:8787/' > /etc/wgetrc
rm -rf  /etc/apt/sources.list
echo 'echo "deb http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted universe multiverse' > /etc/apt/sources.list
echo '# deb- http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted universe multiverse' > /etc/apt/sources.list
echo 'deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse' > /etc/apt/sources.list
echo '# deb- http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse' > /etc/apt/sources.list
echo 'deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse' > /etc/apt/sources.list
echo '# deb- http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse' > /etc/apt/sources.list
echo 'deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-security main restricted universe multiverse' > /etc/apt/sources.list
echo 'Acquire::http {Proxy"http://192.168.168.3:3142"}' > /etc/apt/apt.conf.d/01proxy

echo 'check-certificate = off' > /etc/wgetrc
 echo 'https_proxy = http://192.168.168.3:8787/' > /etc/wgetrc
 echo 'http_proxy = http://192.168.168.3:8787/' > /etc/wgetrc
 echo 'ftp_proxy = http://192.168.168.3:8787/' > /etc/wgetrc

 mv /etc/apt/sources.list /etc/apt/sources.listbk
cat  >>/etc/apt/sources.list <<END
deb http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.cqu.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse
#deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse
deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu bionic stable
deb-srcsrc [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu bionic stable
END






deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main
deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main
deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main
END

e
deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main
deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main
deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main

apt-add-repository -y ppa:rael-gc/rvm
 curl -sSL https://rvm.io/mpapis.asc | gpg --import -
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80  --recv-keys A874136B215467E8  8094BB14F4E3FBBE  23E7166788B63E1E73C62A1B 3B1510FD D259B7555E1D3C58  409B6B1796C275462A1703113804BB82D39DC0E3 E1DD270288B4E6030699E45FA1715D88E1DF1F24  80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 8B3981E7A6852F782CC4951600A6F0A3C300EE8C  4F4EA0AAE5267A6C 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB  D259B7555E1D3C58
  
  
echo "deb [arch=amd64] http://ppa.launchpad.net/rael-gc/rvm/ubuntu bionic main" >> /etc/apt/sources.list 
cat  > install <<END
#/bin/bash
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E1DD270288B4E6030699E45FA1715D88E1DF1F24 

echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main" >> /etc/apt/sources.list 

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 80F70E11F0F0D5F10CB20E62F5DA5F09C3173AA6 

echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu bionic main" >> /etc/apt/sources.list 

wget --quiet -O - http://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - 

echo 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' > /etc/apt/sources.list.d/pgdg.list 

wget --quiet -O - http://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - 

echo 'deb http://deb.nodesource.com/node_8.x bionic main' > /etc/apt/sources.list.d/nodesource.list 

echo 'deb http://mirrors.ustc.edu.cn/nodesource/deb/node_8.x stretch main' > /etc/apt/sources.list.d/nodesource.list 
echo 'deb http://mirrors.ustc.edu.cn/nodesource/deb/node_10.x stretch main' > /etc/apt/sources.list.d/nodesource.list 
mirrors.ustc.edu.cn/nodesource/deb/node_8.x

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv  8B3981E7A6852F782CC4951600A6F0A3C300EE8C

echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu bionic main" >> /etc/apt/sources.list

echo "deb http://mirrors.ustc.edu.cn/nginx/ubuntu bionic main" >> /etc/apt/sources.list.d/nginx.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv  4F4EA0AAE5267A6C 
echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list.d/ondrej-ubuntu-php-bionic.list



curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
echo "deb http://dl.yarnpkg.com/debian/ stable main"  |  tee /etc/apt/sources.list.d/yarn.list

apt-get update 

DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor logrotate locales curl  openssh-server mysql-client postgresql-client redis-tools 

git-core ruby${RUBY_VERSION} python2.7 python-docutils nodejs yarn gettext-base 

libmysqlclient18 libpq5 zlib1g libyaml-0-2 libssl1.0.0 

libgdbm3 libreadline6 libncurses5 libffi6 

libxml2 libxslt1.1 libcurl3 libicu52 

update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX 

locale-gen en_US.UTF-8 

DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales 

gem install --no-document bundler
END
archive.ubuntu.com
deb http://mirrors.cqu.edu.cn/ubuntu bionic main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu bionic-security main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu bionic-updates main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu bionic-proposed main restricted universe multiverse
deb http://mirrors.cqu.edu.cn/ubuntu bionic-backports main restricted universe multiverse

deb-i386 http://mirrors.cqu.edu.cn/ubuntu bionic main restricted universe multiverse
deb-i386 http://mirrors.cqu.edu.cn/ubuntu bionic-security main restricted universe multiverse
deb-i386 http://mirrors.cqu.edu.cn/ubuntu bionic-updates main restricted universe multiverse
deb-i386 http://mirrors.cqu.edu.cn/ubuntu bionic-proposed main restricted universe multiverse
deb-i386 http://mirrors.cqu.edu.cn/ubuntu bionic-backports main restricted universe multiverse

http://mirrors.cqu.edu.cn/
http://mirrors.neu.edu.cn/
cat  > /etc/apt/apt.conf.d/01proxy<<END
Acquire::http {Proxy"http://127.0.0.1:3142"}
END



rm -rf  /etc/apt/sources.list
cat  >>/etc/apt/sources.list<<END
# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb http://archive.ubuntu.com/ubuntu/ bionic main restricted
# #deb- http://archive.ubuntu.com/ubuntu/ bionic main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted
# #deb- http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://archive.ubuntu.com/ubuntu/ bionic universe
#deb- http://archive.ubuntu.com/ubuntu/ bionic universe
deb http://archive.ubuntu.com/ubuntu/ bionic-updates universe
#deb- http://archive.ubuntu.com/ubuntu/ bionic-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://archive.ubuntu.com/ubuntu/ bionic multiverse
# #deb- http://archive.ubuntu.com/ubuntu/ bionic multiverse
deb http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse
# #deb- http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse
# #deb- http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu bionic partner
# #deb- http://archive.canonical.com/ubuntu bionic partner

deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted
# #deb- http://security.ubuntu.com/ubuntu/ bionic-security main restricted
deb http://security.ubuntu.com/ubuntu/ bionic-security universe
#deb- http://security.ubuntu.com/ubuntu/ bionic-security universe
deb http://security.ubuntu.com/ubuntu/ bionic-security multiverse
# #deb- http://security.ubuntu.com/ubuntu/ bionic-security multiverse
deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu bionic stable
END
