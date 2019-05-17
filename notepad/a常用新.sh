cat > /etc/apt/apt.conf<<APTPRXY
Acquire::http { Proxy "http://192.168.168.3:3142"; };
Acquire::http::Proxy { *.lockyse7en.com DIRECT; };
APTPRXY
sed -i "s|us.archive.ubuntu.com|mirrors.cqu.edu.cn|g" /etc/apt/sources.list
sed -i "s|security.ubuntu.com|mirrors.cqu.edu.cn|g" /etc/apt/sources.list
usermod -aG sudo  fengshun
usermod -aG root  fengshun

 echo 'fengshun ALL=NOPASSWD: ALL' > /etc/sudoers.d/fengshun
 apt install openssh-server vim open-vm-tools -yf
 sed -i "s|#PermitRootLogin|PermitRootLogin|g" /etc/ssh/sshd_config
sed -i "s|prohibit-password|yes|g" /etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication yes|PubkeyAuthentication yes|g" /etc/ssh/sshd_config
sed -i "s|#AuthorizedKeysFile|AuthorizedKeysFile|g" /etc/ssh/sshd_config
/etc/init.d/ssh restart
 
 /etc/init.d/ssh restart
export DISPLAY=:0
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\[\033[00;00m\]@\[\033[01;35m\]\h\[\033[00;31m\]:\[\033[00;00m\]\w \[\033[01;32m\]\$ \[\033[01;36m\]'


dpkg --add-architecture i386
ssh-keygen -t rsa -b 2048 -C "rancher@rancher.lockyse7en.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
cp
clip < ~/.ssh/id_rsa.pub
clip < ~/.ssh/authorized_keys2
cp id_rsa.pub authorized_keys
ssh -T git@github.com
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
gpg --keyserver hkp://keyserver.ubuntu.com:80   --send-keys D556BF68EE9B672E 

  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80  --recv-keys  D556BF68EE9B672E
--keyserver hkp://keyserver.ubuntu.com:80  
git config --global user.name "lockyse7en"


RUN /bin/dbus-uuidgen --ensure
RUN useradd -g 999 -u 999 -r -d /home/fengshun -s /bin/bash fengshun
RUN echo "fengshun:1" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd
useradd -m docker
sudo  usermod -aG sudo   fengshun
sudo usermod -aG rvm  fengshun
usermod -aG docker fengshun
usermod -aG sudo fengshun
usermod -aG root  fengshun
 echo 'fengshun ALL=NOPASSWD: ALL' > /etc/sudoers.d/fengshun
sudo groupadd docker  
 echo "root:root" | chpasswd
  echo "fengshun:1" | chpasswd
chmod -R ga+w h5ai
bbs/data/titles

export 
export DISPLAY=:0
gsettings set org.gnome.system.proxy mode auto
gsettings set org.gnome.system.proxy autoconfig-url 'http://192.168.168.10/proxy.pac'
To unset:

gsettings set org.gnome.system.proxy autoconfig-url ''                   
gsettings set org.gnome.system.proxy mode none