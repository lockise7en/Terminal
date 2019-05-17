前言
相信贴吧使用群晖NAS的吧友不在少数，并且在蜜汁菊苣的影响下开始跳进了群晖这个坑。有时群晖官方套件并不能满足我们的需求，于是网上有了社区套件，如著名的SynoCommunity，如果社区套件还不能满足需求那咱就得自己动手丰衣足食了。
环境搭建
这一步很简单，我们需要64位的Ubuntu,Debian。推荐使用最新稳定版本。在配置好sources.list后即可开始配置编译环境。
请执行以下代码，安装必要的库和软件：
aptitude install build-essential debootstrap python-pip automake libgmp3-dev libltdl-dev libunistring-dev libffi-dev ncurses-dev imagemagick libssl-dev pkg-config zlib1g-dev gettext git curl subversion check bjam intltool gperf flex bison xmlto php5 expect libgc-dev mercurial cython lzip cmake swig lib32z1 lib32ncurses5
pip install -U setuptools pip==1.5.4 wheel==0.23 httpie
注意，以上代码必须以root权限执行。
在这之后，就可以进行下一步了。
编译
在这一步，我用mktorrent举例，说明如何进行交叉编译。
首先，我们得下载目标机型的GCC，全部机型对应的GCC下载地址在http://hitechbeijing.info/What_kind_of_CPU_does_my_NAS_have/可以找到。
以DS213j为例，使用wget http://sourceforge.net/projects/dsgpl/files/DSM%205.1%20Tool%20Chains/Marvell%20Armada%20370%20Linux%203.2.40/gcc464_glibc215_hard_armada-GPL.tgz下载GCC
下载完后使用tar -xzvf gcc464_glibc215_hard_armada-GPL.tgz -C /usr/local 将压缩包解压至/usr/local
接下来配置Makefile,分别将CC,LD,CFLAGS,LDFLAGS参数改为以下参数，并去掉参数前的注释。
CC= /usr/local/arm-marvell-linux-gnueabi/bin/arm-marvell-linuxgnueabi-gcc
LD= /usr/local/arm-marvell-linux-gnueabi/bin/arm-marvell-linuxgnueabi-ld
CFLAGS += -I/usr/local/arm-marvell-linux-gnueabi/arm-marvell-linuxgnueabi/libc/include
LDFLAGS += -L/usr/local/arm-marvell-linux-gnueabi/arm-marvell-linuxgnueabi/libc/lib
除此之外我们还得修改编译输出路径
DESTDIR = ./bin
这里只能使用绝对路径。
其余的参数就根据官方文档进行修改就好，如mktorrent官方推荐使用如下参数：
USE_PTHREADS = 1
USE_OPENSSL = 1
USE_LONG_OPTIONS = 1
USE_LARGE_FILES = 1
配置好Makefile后便可以进行make&makeinstall了。
在编译后我们可以在mktorrent-1.0/bin下找到刚才编译输出的可执行文件，而且是带目录层级的，即usr/local/bin/mktorrent。
打包
这一步应该算是比较复杂的一步
第一步先打包程序文件，在bin目录下执行tar -czvf package.tgz * ，即将该目录下所有文件打包为package.tgz
接下来需要校验刚才打包的程序文件
md5sum package.tgz
记下校验码备用。
接下来创建INFO文件
package="mktorrent" 
#程序名称
version="1.0" 
#程序版本
arch="armada370 armada375 armadaxp" 
#目标机器cpu架构，可以在http://hitechbeijing.info/What_kind_of_CPU_does_my_NAS_have/上找到
distributor="SynoCommunity" 
#发布者
distributor_url="http://synocommunity.com" 
#发布者网址
maintainer="SynoCommunity" 
#维护者
maintainer_url="http://synocommunity.com" 
#维护者网址
firmware="5.0-4458" 
#DSM版本需求
startable="no"
#是否需要启动，即最终用户是否需要启动/停止套件
displayname="openssl" //程序显示名称，这个不用多解释
checksum="b2a1e90e593889595f7e20c4ab6222e6" 
#md5校验码，填入之前记下的校验码
只需要这些基本信息一个INFO文件即可生效
除此之外，我们还需要一个72*72的PACKAGE_ICON.PNG文件作为程序图标。
接下来该写启动脚本了
新建scripts文件夹，并进入
新建common文件
输入以下代码
#!/bin/sh
INSTALL_DIR="/usr/local"
DO_LINK()
{
ln -s ${SYNOPKG_PKGDEST}/bin ${INSTALL_DIR}/bin 
#创建软链接,${SYNOPKG_PKGDEST}为最终用户选择的程序安装目录。
}
DO_REMOVE()
{
rm -f ${INSTALL_DIR}/bin/mktorrent
#移除软链接
}
保存文件
接下来创建postinst，postuninst，postupgrade，preinst，preuninst，preupgrade脚本，这几个脚本的用处分别为安装后执行脚本，卸载后执行脚本，升级后执行脚本，安装前执行脚本，卸载前执行脚本，升级前执行脚本。
postinst
#!/bin/sh
. `dirname $0`/common
DO_LINK
exit 0
以上脚本意味引入common文件，执行DO_LINK函数，即创建软链接
postuninst
#!/bin/sh
. `dirname $0`/common
DO_REMOVE
exit 0
以上脚本意味引入common文件，执行DO_REMOVE函数，移除软链接。
postupgrade
晕倒还没写完，继续
#!/bin/sh
exit 0
由于升级没啥事可做，直接exit 0就好
其余文件也是如此。
还剩下start-stop-status文件，此文件就是最终用户点击启用，停用，以及DSM判断套件状态的脚本。
#!/bin/sh
. `dirname $0`/common
INSTALL_DIR="/usr/local"
case $1 in
start)
exit 0
;;
stop)
exit 0
;;
status)
if [ -e "${INSTALL_DIR}/bin/mktorrent" ]; then
exit 0
else
exit 1
fi
;;
log)
echo "${INSTALL_DIR}/install.log"
exit 0
;;
*)
exit 1
;;
esac
由于不需要start,stop，自然start,stop没啥事可做，直接exit 0.
判断状态直接检测是否存在软链接，如果存在则为正常状态，如果不存在则为异常。
日志没啥可说的，指定文件即可。
在这一步之后，回到bin目录，使用tar -cvf mktorrent.spk * 创建套件安装包，当然这样是不包含签名的。
还有程序安装配置，图形化界面编程，下回再来分解。