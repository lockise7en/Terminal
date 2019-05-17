#!/bin/bash
#1
curl patch ca-certificates gawk g++ gcc libssl-dev make libc6-dev patch openssl ca-certificates curl zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libgmp-dev libreadline6-dev
 apt-get  install -y -f libreadline-dev zlib1g-dev  g++ gcc make libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libreadline6-dev libssl-dev
yum install gcc-c++ patch readline readline-devel zlib zlib-devel
    libyaml-devel libffi-devel openssl-devel make
    bzip2 autoconf automake libtool bison iconv-devel sqlite-devel
#2
gpg --keyserver hkp://keys.gnupg.net --recv-keys 8094BB14F4E3FBBE 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
proxychains curl -sSL https://rvm.io/mpapis.asc | gpg --import -
proxychains curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm reload
#3
rvm requirements run
proxychains rvm install  2.3.6p384
#4
2.4.4
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
 gem install jekyll bundler 
bundle config mirror.https://rubygems.org https://gems.ruby-china.org
gem sources --add  https://localhost/rubygems/  

gem sources --add  http://192.168.168.2/mirrors/rubygems
 gem sources --remove https://rubygems.org/
bundle config mirror.https://rubygems.org https://mir.lockyse7en.com/rubygems/  https://mirrors.tuna.tsinghua.edu.cn/rubygems/ 
$ gem sources -l
https://mirrors.ustc.edu.cn/
Downloading https://github.com/rvm/rvm/archive/1.29.3.tar.gz
Downloading https://github.com/rvm/rvm/releases/download/1.29.3/1.29.3.tar.gz.asc
bundle config mirror.https://rubygems.org  https://nas.lockyse7en.com/rubygems/  

 
 npm config set registry https://registry.npm.taobao.org
 yarn config set registry https://registry.npm.taobao.org
  npm install -g yrm
  yrm  use taobao

 sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
 npm install -g yrm
  yrm  use taobao
