#!/bin/bash
apt-get update && 
sudo apt-get -y install  unzip \
xz-utils \
curl \
bc \
git \
build-essential \
cpio \
gcc libc6 libc6-dev \
kmod \
squashfs-tools \
genisoimage \
xorriso \
syslinux \
isolinux \
automake \
pkg-config \
p7zip-full \
proxychains \
git

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
gpg --list-secret-keys --keyid-format LONG
git config --global user.signingkey D556BF68EE9B672E
git config --global user.name "lockyse7en"
git config --global user.email lockyse7en@outlook.com
git config --global http.proxy http://127.0.0.1:18787
git config --global https.proxy https://127.0.0.1:18787

git config --global http.proxy http://172.17.0.1:18787
git config --global https.proxy https://172.17.0.1:18787
git config --global http.proxy http://192.168.168.3:18787
git config --global https.proxy https://192.168.168.3:18787
cat ~/.ssh/id_rsa.pub >>  ~/.ssh/authorized_keys
cat ~/.sshid_rsa.pub >> cat ~/.ssh/authorized_keys2
echo "use_proxy = on" >> /etc/wgetrc

cat > authorized_keys<<END
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAEAQDC+eDEchF7vu/hsAl3qU97rl4yTX4AHYZEe5TNyUWa5hnbYD4svb/SsXVZMbgIee0R8cp7ZbJQ5jO+ipAxhnezt0sRgagUDu9glpWqvLaJr3KDLhAReN1oB0T8FwsAzzlN6PV4ZJUoLlPY0IkKH1K9Bgcv6mgA4AC7bcBQsuxkQKuqPq4Q5xB/gPZ7kq87vylD3ZE6S26TLJqqMJHGKGg8wwhtiyzj+WC5fmoJV8+w35IIhCsmgFj0YS6ByrQS45SZBhEojCAx+yNpv9uMgIs0kmIyXBxtwe3xZdgzIlUn4F3BXOisIG1Cyr18yh47AfGPnt4odxfZ2dBRmn8fJlt5zM2VOa4X4fwn+mepQC+wPgHPLpCSnO4T5awr+8mDq6laD2Fa524zXc0HUKtWC3sEzBhwblXCIp8sl7a3B47l4SQFMPMO57MJu0jEkwcQE44Q3VteFnJB2Xzyn33KycZw10X43HlK1J9KQBltKUUca6ATw7xuWAwMHKdDHWpFRqWnfOrKytXEUmflU/Oo13f3eBnB5gv8SlhtTAedsxLJ9Z+TjjnvC4su+9/WkZG45yoTCN0sXj/L7xfpITaAnIt75N4FC6IfpS9reApUSQz8M/dhzBCtsrZmf80xxYKgAwyvO9HINQ9+W+6I/TJ1Wtl0HhOAncWnQHZClnxifx5H18nWo9t7/AWZ+uoSd5xp75Laty2hwJv+OaRuVCsDqONo7nJzPPW7HlRw4ANW9ysZhe4V8OW2W0j27v9gM/tG9Pft5+PUVYK2fhINlO+4sRlDh/jPqV4KPRdGt3F08frrPBkrvWbdaz3s8X3eFlfwGAwp4lbEChh2EHioAjP0EwJ6W6CULG46GQbhA1MX5cV50vx9DIt/pa8JvJifJz0rWlE1LK2JIJ5zm0bmjs2iWzZCEkm1nGJKZwuuWYixxatUEkrIIPxIv2vwn6R66DTTTii2c8Tp7GmKn8aaFJyJMxdnfMB9pp7T9Oy1dyPWmov56Mui5iJ8lC16MhiIZ4v77Rz8dIujpV+AYU0aoDhSlECenR5kg77vROIWt7YAm+4Qw98k15T5Pb81bsQfNst6nRXX69eLndOiR3RKrvylh3keiLRQSa8zy/BoY/6oW7j8IyfDSE4uRYQUAcONCfy4CmUFKOCNjjoarl6K0ZWWFUdg0QrKYurmnXyYGJ82Z8U38p5b9hAei6J546xXk8AgF6x/Tx8CiCYdqb2pAwmrageMW+ZDnNc6HXbjRIr8Gv732IZwc6cVLZxrIyQqlws6UPOLJkpki/F+MOnVenJCJHtSx9dK4mUN+Ush8ryXHWTURYArhCPf7pzJ+K7bA6ib0wpCW6HwLxxNYNDx7o1b/1Yz lockyse7en
END

#echo "/usr/ssl/certs/ca-bundle.crt" >> /etc/wgetrc
echo "check-certificate = off" >> /etc/wgetrc
echo "http_proxy = http://127.0.0.1:18787/" >> /etc/wgetrc
echo "https_proxy = https://127.0.0.1:18787/" >> /etc/wgetrc
echo "ftp_proxy = http://127.0.0.1:18787/" >> /etc/wgetrc
echo "use_proxy = on" >> /etc/wgetrc
echo "check-certificate = off" >> /etc/wgetrc
echo "http_proxy = http://172.17.0.1:18787/" >> /etc/wgetrc
echo "https_proxy = https://172.17.0.1:18787/" >> /etc/wgetrc
echo "ftp_proxy = http://172.17.0.1:18787/" >> /etc/wgetrc
echo "use_proxy = on" >> /etc/wgetrc
echo "check-certificate = off" >> /etc/wgetrc
echo "http_proxy = http://192.168.168.3:8787/" >> /etc/wgetrc
echo "https_proxy = http://192.168.168.3:8787/" >> /etc/wgetrc
echo "ftp_proxy = http://192.168.168.3:18787/" >> /etc/wgetrc
export HTTP_PROXY=http://192.168.168.3:18787/
export HTTPS_PROXY=https://192.168.168.3:18787/
export FTP_PROXY=http://192.168.168.3:8787/
export HTTP_PROXY=http://192.168.168.3:18787/
export HTTPS_PROXY=https://192.168.168.3:18787/
export FTP_PROXY=http://192.168.168.3:18787/
echo "scosk_proxy = http://172.17.0.1:18787/" >> /etc/wgetrc

rm -rf /etc/proxychains.conf
cat >>/etc/proxychains.conf<<END
strict_chain
quiet_mode
#proxy_dns 
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000
localnet 127.0.0.0/255.0.0.0
quiet_mode

[ProxyList]
http    127.0.0.1 18787
#https   127.0.0.1 18787
#ftp    127.0.0.1 18787
END
this has worked perfectly fine. All you need to do is just to replace  user@192.168.1.1  with your own user for that particular host  shareimprove this answer edited Aug 13 '17 at 9:14  Aditya Kresna Permana 5,54641627 answered Feb 23 '16 at 7:41  Faisal Sarfraz 348213 This works beautifully, thank you. – LessQuesar Apr 3 '17 at 4:15 You're welcome @LessQuesar – Faisal Sarfraz Apr 18 '17 at 12:03  add a comment up vote 2 down vote There is already a command in the ssh suite to do this automatically for you. I.e log into a remote host and add the public key to that computers authorized_keys file.  ssh-copy-id -i /path/to/key/file user@host.com If the key you are installing is ~/.ssh/id_rsa then you can even drop the -i flag completely.  Much better than manually doing it!  shareimprove this answer answered Nov 10 '17 at 14:03  tkarls 9851419 add a comment Your Answer    Sign up or log in  Sign up using Google  Sign up using Facebook  Sign up using Email and Password   Post as a guest Name  Email  required, but never shown By posting your answer, you agree to the privacy policy and terms of service.  Not the answer you're looking for? Browse other questions tagged ubuntu-11.10 ssh-keys authorized-keys or ask your own question. asked  5 years, 5 months ago  viewed  75,650 times  active  3 months ago  Work from anywhere Senior Infrastructure Engineer f/m (100% Remote) Jaumo GmbHNo office location €60K - €150KREMOTE kubernetesdevops UI/Full-Stack Developer CodershipNo office location €48K - €78KREMOTE user-interfacesingle-page-application Solutions Architect - Ruby/Python/React Analytics FireNo office location REMOTE reactangularjs Cloud Infrastructure/Release Management Engineer GLAMSQUADNew York, NY REMOTE amazon-ec2git Work remotely - from home or wherever you choose.  Browse remote jobs Linked 6 Python subprocess .check_call vs .check_output Related 236 AWS ssh access 'Permission deni
git commit -S -m

ssh-keygen -t rsa -C "lockyse7en@outlook.com" -b 4096
git init


ssh-keygen -t rsa -b 2048 -C "rancher@rancher.lockyse7en.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
cp
clip < ~/.ssh/id_rsa.pub
clip < ~/.ssh/authorized_keys2
cp id_rsa.pub authorized_keys
ssh -T git@github.com
git config --global user.name "lockyse7en"
git config --global user.email lockyse7en@outlook.com
git config --global http.proxy http://192.168.168.3:18787
git config --global https.proxy http://192.168.168.3:18787
--system
--system
git config --global http.proxy http://192.168.168.3:18787
git config --global https.proxy http://192.168.168.3:18787
git config --global http.proxy http://172.19.0.1:8787
git config --global https.proxy http://172.19.0.1:8787
git config --global https.proxy http://172.17.0.1:49919
git config --global http.proxy http://172.17.0.1:49919
git config --global http.proxy http://192.168.168.3:18787
git config --global https.proxy http://192.168.168.3:18787
git config --global http.proxy http://192.168.168.3:18787
git config --global https.proxy http://192.168.168.3:18787
git config --global http.proxy http://192.168.168.3:18787
git config --global socks.proxy http://172.17.0.1:1080
git config --global https.proxy http://192.168.168.3:18787
git config --global http.proxy http://192.168.168.3:18787
git clone ssh://[Git 用户]@[您的 Synology 服务器 IP 地址或主机名]/[Git 存储库路径]

git clone ssh://root@lockyse7en.com/git/spk.git
git clone ssh://root@172.17.0.1/git/router/koolshare.github.io.git
git clone ssh://root@172.17.0.1/git/router/lede/web
git clone ssh://root@172.17.0.1/git/git/gogs-spk.git