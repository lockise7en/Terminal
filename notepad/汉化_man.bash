汉化 man
apt-get install language-pack-zh-hans language-pack-zh-hans-base  ttf-mscorefonts-installer  ttf-wqy-zenhei fontconfig  fonts-wqy-microhei
apt install  language-pack-zh-hans language-pack-zh-hans-base -y
locale-gen zh_CN.GB18030 && locale-gen zh_CN.GB2312 %% locale-gen zh_CN.UTF8
locale-gen zh_CN.GB18030 && locale-gen zh_CN.GB2312 %% locale-gen zh_CN.UTF8
apt-get install -y ttf-wqy-zenhei language-pack-zh-hans language-pack-zh-hans-base -y -f

update-locale LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8 LC_MESSAGES=POSIX \
 && locale-gen zh_CN.UTF-8 \
 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
#中文字体，别忘了同意eula
apt install fontconfig -y
 apt install ttf-mscorefonts-installer -y
#下面的再执行一遍以防万一
 apt install -y --force-yes --no-install-recommends ttf-mscorefonts-installer  ttf-wqy-zenhei fontconfig  fonts-wqy-microhei ttf-wqy-zenhei  fontconfig  ttf-wqy-zenhei
 apt install -y --force-yes --no-install-recommends ttf-wqy-zenhei
 export LANGUAGE='zh_CN:zh' LANG='zh_CN.UTF-8' LC_ALL='zh_CN.UTF-8' LC_MESSAGES=POSIX \
 locale-gen zh_CN.UTF-8 \
 DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
 locale-gen zh_CN.UTF-8 
 LC_CTYPE＝zh_CN.XXXX，LANG=en_US.XXXX LC_MESSAGES=POSIX
 
 
update-locale LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.zh LC_MESSAGES=POSIX LC_ALL=zh_CN.UTF-8 locale-gen=zh_CN.UTF-8 LC_NUMERIC=zh_CN.UTF-8 LC_TIME=zh_CN.UTF-8 LC_MONETARY=zh_CN.UTF-8 LC_PAPER=zh_CN.UTF-8 LC_IDENTIFICATION=zh_CN.UTF-8 LC_NAME=zh_CN.UTF-8 LC_ADDRESS=zh_CN.UTF-8 LC_TELEPHONE=zh_CN.UTF-8 LC_MEASUREMENT=zh_CN.UTF-8 && \
locale-gen zh_CN.UTF-8 &&  \
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales


 && apt install manpages-zh
vi /etc/manpath.config


LC_MESSAGES=POSIX  
:1,$s#/usr/share/man#/usr/share/man/zh_CN#g:wq!
sed -i "s|#PermitRootLogin prohibit-password|PermitRootLogin yes |g" /etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication yes|PubkeyAuthentication yes|g"  /etc/ssh/sshd_config
sed -i "s|#AuthorizedKeysFile .ssh/authorized_keys|AuthorizedKeysFile .ssh/authorized_keys|g"  /etc/ssh/sshd_config
sed -i "s|/usr/share/man|/usr/share/man/zh_CN |g" /etc/manpath.config
sed -i "s|cn.archive.ubuntu.com/192.168.168.9/repo/ubuntu/g" /etc/apt/sources.list
sed -i "s|/opt/lampp|/opt/bitnami|g" bitnami/bitnami
sed -i "s|cn.archive.ubuntu.com|mirrors.ustc.edu.cn |g" /etc/apt/sources.list
sed -i "s|mirrors.ustc.edu.cn |mirrors.ustc.edu.cn|g" /etc/apt/sources.list
sed -i "s|mirrors.ustc.edu.cn|rpm.nodesource.com |g" /etc/yum.repos.d/nodesource-fc.repo
sed -i "s|SSLEngine on|SSLEngine off|g" apache2/conf/bitnami/bitnami.conf
sed -i "s|SSLEngine on|SSLEngine off|g" apache2/conf/extra/httpd-ssl.conf
sed -i "s|SSLEngine on|SSLEngine off|g" apache2/conf/original/extra/httpd-ssl.conf


