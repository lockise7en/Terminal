#!/bin/bash
echo "personal-digest-preferences SHA256" >> ~/.gnupg/gpg.conf
gpg --import http://192.168.168.2/aptoncd-DVD1/Release.sec
apt-key add http://192.168.168.2/aptoncd-DVD1/Release.pub
echo "deb [arch=amd64] http://192.168.168.2/aptoncd-DVD1 ./" >> /etc/apt/sources.list.d/local.list