service restart_dnsmasq)
More
service restart_dnsmasq
AsusWRT-Merlin
AsusWRT-Merlin 是基于华硕路由器固件的一个嵌入式 Linux 系统，它号称是“增强版”的华硕固件。并且它不仅限于安装在华硕设备上，例如我自己的网件（Netgear）路由器（R7000）也能完美的使用。

跟 Merlin 类似的还有大名鼎鼎的 OpenWRT 以及其衍生项目，例如 LEDE、DD-WRT 等等。相比几乎完全随意读写的 OpenWRT，Merlin 并没有那么自由，它的文件系统多数都是只读的（这点在之后会有解释）。
由于某些原因（下面会解释）我的路由器不能用 OpenWRT，而显然 OpenWRT 是最适合我的。但是，不能随意读写文件系统的 Merlin 不表示就扼杀了 Linux 的开放性，这也是我最终依旧选择 Merlin 的理由。

PS：Merlin 固件在国内，很多路由器党都亲切的叫它：梅林。

项目地址：https://github.com/RMerl/asuswrt-merlin

Entware
Entware 是一个嵌入式 Linux 设备的软件仓库集成工具，也就是传统 Linux 上的包管理工具，例如 Debian 的 dpkg、CentOS 的 yum 等。
它们可以通过网络在远程仓库上拉取并安装所需要的包，同时自动解决依赖问题，是系统上不可或缺的一部分。典型的例子就是：

在 Debian/Ubuntu 上，这样安装仓库软件：

apt install vim
使用本地安装包：

dpkg -i vim.deb
Entware 也提供这样的 CLI 工具，它就是 opkg，从名字就能看出来模仿的是 dpkg。opkg 类似于 apt 和 dpkg 的结合，它既能管理本地包也能安装远程仓库的包。例如：

opkg install vim
opkg install ./vim.ipk
介绍完了主要的两大角色，就要开始一步一步来配置环境了。

安装 Merlin
确认 Merlin 是否支持设备

从这里搜索你的路由器型号足以确认。为了保险起见，建议再去谷歌和百度搜索“路由器型号+梅林”字眼看下是否有坑，例如我当初就没有搜索借鉴下前人的经验，冲着 OpenWRT 去买的 R7000 到头来发现却是存在大坑的。如果我在这之前调查过，应该也不会买这个路由器了。

从官方固件刷入梅林

假如你是 Netgear 的路由器，当你在下载好固件压缩包以后，解压出来，有两个文件是可能用到其一的。一个是从官方升级到梅林的 .chk 后缀的文件。 路由器 WEB UI 上选择「管理」-「路由器升级」页面。 选择 .chk 刷入，即成功。

从梅林固件升级

如果你已经是梅林固件，不要设置任何东西，直接选择 .trx 升级就是。 路由器 WEB UI 上选择「系统管理」，切换到「固件升级」页面。完成即成功。

注意：很多论坛上的教程都是普通玩家一传十，十传百流下来的内容。其实很多都是错误的。例如，升级之前和之后他们强调恢复出厂设置各一次，其实这是没必要的，但是做了也不会有坏处。

恢复出厂设置附加说明：恢复出厂设置的主要目的是重置 nvram 中的内容（一般是配置项），假设你从 Merlin 刷回原厂，nvram 中的配置项可能是不兼容的，那么你确实最好应该升级时勾上恢复设置。但是如果你是 Merlin 或者原厂之间的版本升级，一般来讲恢复出厂设置是多余的。刷之前恢复一次，刷之后又恢复一次，更是没事找事。

误传最大的是，很多人在教程里边把 .chk 文件称之为“过渡固件”，刷了“过渡固件”再刷 .trx 固件才是完整的梅林系统。这是多此一举的，.chk 格式的封装是为了方便官方固件用户升级到梅林的，.trx 是方便旧版梅林固件升级新版的。并不需要第二次刷入 .trx ，因为所谓的 .trx 过渡固件其实就是完整的系统。

Merlin 的基本设置
假设你已经安装好了，这里介绍几个必要的设置项。它跟路由器功能无关，跟梅林的“玩法”有关。在这之前你得手动配置好网络。

开启 SSH

选择「系统管理」，切到「系统设置」页面。SSH Deamon 栏目下面，将 SSH 功能开启，密码或者 Key 随意，能让你 SSH 进入路由器系统即可。

启用 JFFS 自定义脚本和配置

Persistent JFFS2 partition 栏，Enable JFFS custom scripts and configs 选择「是」，把上面的格式化也选择上。

确保你记得路由器用户名和密码，重启路由器。然后启动以后就可以 SSH 到路由器后台系统了，用户名和密码跟路由器登录用的是同一个。

此时，这个系统是没有包管理功能的，并且多数目录都是只读的。虽然你是 root 权限的用户，但是你没法在随意写入文件。例如，你在根目录创建一个文件夹，会提示：

admin@NETGEAR-9599:/# mkdir test_dir
mkdir: can't create directory 'test_dir': Read-only file system
你在绝大部分目录下都是如此，虽然你可以在 /tmp 目录下任意写入内容，但是毕竟是 /tmp，重启可能就消失了。
诈一看，这个系统不能自由的写入内容的话，好像什么用都没有了。其实不是，既然内置空间是“有保护”的，那么我们可以用外置设备充当额外的“硬盘空间”，就可以有完全的读写权限的空间使用了。当然这个“硬盘”对于路由器而言，就是外置的 U 盘。R7000 支持插入一个 U 盘。

自动挂载 U 盘
上面提过了，梅林用 Entware 需要一个可随意读写的空间，这个空间需要挂载到 /opt 目录。插上你的 U 盘，执行 df 命令：

admin@NETGEAR-9599:/tmp/home/root# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root                27008     27008         0 100% /
devtmpfs                127756         0    127756   0% /dev
tmpfs                   127860       588    127272   0% /tmp
/dev/mtdblock4           90880      2196     88684   2% /jffs
/dev/sda1             30384076    229480  28611172   1% /tmp/mnt/sda1
从上面的输出可以看到，我的 U 盘是 sda1 设备。记住这个设备名称，直接终端执行以下内容：

cat << EOF > /tmp/script_usbmount.tmp
if [ \$1 = "/tmp/mnt/sda1" ]
then
ln -sf \$1 /tmp/opt
/opt/etc/init.d/rc.unslung start
fi
EOF
nvram set script_usbmount="`cat /tmp/script_usbmount.tmp`"
cat << EOF > /tmp/script_usbumount.tmp
if [ \$1 = "/tmp/mnt/sda1" ]
then
/opt/etc/init.d/rc.unslung stop
fi
EOF

其中“/tmp/mnt/sda1”替换为自己的 U 盘路径，然后执行（将上面的脚本内容永久的保存在 NVRAM 中）：

nvram set script_usbumount="`cat /tmp/script_usbumount.tmp`"
nvram commit 
重启即可看到效果。其目的是自动挂载（卸载） U 盘到 /opt 目录。待系统启动以后，cd 进入 /opt 自行确认是否是 U 盘路径。

注意：在使用 U 盘前，请先格式化成 Linux 所兼容的文件系统，对于 R7000 的 Merlin 推荐 ext4 格式 。

安装 Entware
如果你在谷歌搜索 Entware 然后按照项目 wiki 安装那就大错特错了。Entware 有两个项目，一个是 entware 一个是 entware-ng，如果你不幸企图安装到前者，那就更倒霉了。因为那不是给 Merlin 准备的，或者说不支持 Merlin，因为它很早就过时了。

其实 Merlin 在 15 年开始的某个版本上就已经内置了 Entware 的安装脚本了，直接终端执行即可：

entware-setup.sh
进入交互：

admin@NETGEAR-9599:/tmp/home/root# entware-setup.sh
Info:  This script will guide you through the Entware installation.
Info:  Script modifies "entware" folder only on the chosen drive,
Info:  no other data will be changed. Existing installation will be
Info:  replaced with this one. Also some start scripts will be installed,
Info:  the old ones will be saved on Entware partition with name
Info:  like /tmp/mnt/sda1/jffs_scripts_backup.tgz
Info:  Looking for available partitions...
[1] --> /tmp/mnt/sda1
=>  Please enter partition number or 0 to exit
[0-2]:
选择你的 U 盘路径，因为 R7000 只能插一个外置储存所以通常是 1。之后就是不断的回车确认即可。等待安装完成以后，执行 opkg 命令，看是否正常，如果无异常，恭喜你，Entware 环境安装成功。

此时，你进入 /opt 目录，会发现生成了以下文件系统结构：

admin@NETGEAR-9599:/tmp/home/root# cd /opt/
admin@NETGEAR-9599:/tmp/mnt/sda1/entware# ls
bin    etc    lib    sbin   share  tmp    usr    var
admin@NETGEAR-9599:/tmp/mnt/sda1/entware# 
没错，Entware 将会把软件安装在这里，并且一切仓库软件所需要的东西都会在这里有一份跟标准安装所依赖的一样的结构目录文件。

例如 nginx 的配置目录在 /etc/nginx 中，但是根目录的 /etc 不允许写入内容，那么 Entware “模拟”一份同样的环境，换到 /opt/etc/nginx 即可。随意读写的 /opt 目录此时相当于系统的根目录。
软件可执行文件会被安装到 /opt/bin 中，并且该路径存在于 PATH 变量中。跟正常 Linux 系统安装到 /usr/bin 或者 /usr/local/bin 是一样的效果。

PS：刚装上以后必须得执行一次更新命令下载仓库索引到本地：

opkg update
Optware
Optware 是一个将环境安装在 /opt 目录的软件集成环境，如果你跟我一样被 Merlin 官方 wiki “坑过”，那么你可能在使用 Entware 之前先使用的 Optware，因为 wiki 上 Optware 的内容在 Entware 之前。

咋一看，好像 Optware 更适合梅林。但是 Entware 也完全的支持 Merlin 这种 /opt 环境，并且更加完善，同时也号称 Optware 的替代品。
在使用 Entware 之前我用了 Optware，Optware 有自己源，跟现在的 Entware 也有一点区别。opkg 和 ipkg 命名不同就不提了，在 Optware 中是有 /opt/local 目录的，但是 Entware 没有。如果在 Merlin 上用 Optware 也不是不行，只是 Optware 不仅没有 Entware 支持好，并且还有很明显的 BUG。所以这里，我就提一下 Optware，并不推荐大家用 Optware。

如果你要问我，Optware 有什么明显 BUG？

/opt/local 中的 bin 以及 sbin 目录不在环境变量中，会导致许多软件的可执行入口失效，需要：

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
/opt/etc 目录缺少例如 profile 这样的系统配置文件

python 安装 pip 以后，无法获取任何包。因为 pypi 是 HTTPS，Optware 默认的 SSL 支持有问题

上面也说过了 ipkg 是自己的源，没有国内的镜像站导致安装软件速度过于缓慢。而且 ipkg 的源恐怕远不如 opkg 源的更新速度和质量以及数量。例如很重要的 python-pip 包就没有，需要用 python 自己根据脚本安装，安装到 /opt/local 目录以后又要解决环境变量问题。

安装 Python
到这一步，Merlin 已经配置好了，Entware 也完成了，基本大功告成了，此时的 Merlin 可以当作一个自由的嵌入式 Linux 使用了。那么，我首先推荐安装支持最为完美的脚本语言 Python 的环境：

安装 python（默认 2.7 版本）：

opkg install python
安装 pip

opkg install python-pip
此时别急，这时候的 pip 是有问题的，几乎安装不上任何包，但是并不是硬件架构的原因，是因为 setuptools 版本太旧了。需要：

pip install --upgrade setuptools
升级 setuptools 即可。你以为这样就能用了？

慢，如果你就此打住的话，会发现许多包含 native code 的包编译不了，原因当然是没有 python-dev 了。但是你直接安装 python-dev 又会出现这样的错误：

Collected errors:
 * check_data_file_clashes: Package python-dev wants to install file /opt/lib/libpython2.7.so
        But that file is already provided by package  * python-base
 * check_data_file_clashes: Package python-dev wants to install file /opt/lib/libpython2.7.so.1.0
        But that file is already provided by package  * python-base
 * opkg_install_cmd: Cannot install package python-dev.
原因和 python-base 包的文件冲突了。需要这样（覆盖掉）：

opkg install python-dev --force-overwrite
执行完上面的命令后，此时 Python 才能完美使用。

有关 Git
Git 其实没有啥问题，但是，你很有可能装错包了。如果你是直接 opkg install git 安装的话，你将无法拉取 HTTPS 协议的 git 地址。也就是说，这么大的 github 克隆不下来任何仓库。你需要安装它：

opkg remove git
opkg install git-http
此时的 git 才能正常克隆 https 协议的仓库。

给系统设置虚拟内存
依次执行：

dd if=/dev/zero of=/tmp/mnt/sda1/swapfile bs=1024 count=512000
mkswap /tmp/mnt/sda1/swapfile
swapon /tmp/mnt/sda1/swapfile
然后，创建启动脚本：

echo '
#!/bin/sh
# Turn On Usage Of Swapfile
if [ -f "/tmp/mnt/sda1/swapfile" ];then
swapon /tmp/mnt/sda1/swapfile
echo "Turning Swapfile On"
fi
' >> /jffs/scripts/post-mount
给执行权限：

chmod a+rx /jffs/scripts/*
大功告成。如果你对 swap 大小不满意请自行修改（注意 U 盘路径）。

附加
关于为什么 R7000 不能使用 OpenWRT？

OpenWRT 是支持 R7000 的，并且我也用过。我指的是无法正常使用路由器的功能，最重要的无线功能是无法启用的。原因是 R7000 的相关硬件的驱动是闭源的。如果你完全将其作为有线路由器来使用，OpenWRT 也未尝不可。

为什么 Merlin 可以让 R7000 使用无线？

因为华硕的一些路由器跟 R7000 用了同样的硬件，Merlin 有对应驱动的内核。但也因为如此，R7000 的 Merlin 内核一直处在 2.6 版本，这对于一个常更新的系统是一个很大的弊端。

为什么华硕不更新驱动支持新内核？

貌似很多人都有这个想法。但其实，驱动是对应厂商提供的，华硕也无能为力。在硬件不开源以及厂商不更新的情况下，可能只能把这个 2.6 内核使用下去。

2.6 这么旧的内核有什么短板？

目前很多公司生产环境 RH 系列的系统都是用的 2.6 内核，对于大多数情况而言是没有影响的。但是不排除有例如一些新元素不对旧内核进行支持的情况（例如高版本的 Docker、TCP-BBR 算法等）。当然，这种情况在嵌入式系统上概率会更小。

关于内核版本
在后续的了解中，我知道了原来 DD-WRT 是能在高版本内核（最新版已经是 4.4）中使用无线功能的。原因是 DD-WRT 和厂商有商业关系，所以解决了驱动问题。
于是我兴奋的去尝试了 DD-WRT，不得不说它是个非常优秀的路由器系统，有庞大的配置项。但可惜的是，我一直无法成功配置 Optware 或者 Entware 的环境。并且是由于一些莫名其妙的问题导致的，让人匪夷所思。例如，在 DD-WRT 的系统上，我无法执行生成的任何一个二进制可执行文件，这导致所有东西无法安装或者安装以后无法运行。

经过长时间的资料搜索，仍然无法解决。后来就刷回 Merlin 了，这也是我强烈推荐 Merlin 的原因。DD-WRT 可以一试，希望你们没有或者能解决我当时没能解决的问题。

UPDATE：DD 的所有问题已经解决，详情点击这里。

后续
后面还有解决 Ruby 的 gem、NodeJs 不兼容等问题和对 Lua 的推荐。以及一些有实际作用的应用，有时间会慢慢补充上来。

关于为什么只测试和使用脚本语言，因为 opkg 好像没有 Java，其他编译型语言需要交叉编译后上传二进制文件，麻烦，没特殊情况不会考虑使用。
echo '
#! /bin/sh
if [ "$1" = "/tmp/mnt/sda1" ] ; then
  ln -nsf $1/entware /tmp/opt
fi
sh /koolshare/scripts/swap_load.sh

if [ -f "/jffs/fastdick/swjsq.py " ];then
nohup python /jffs/fastdick/swjsq.py  >/dev/null 2>&1 &
echo "fastdick On"
fi
' >> /jffs/scripts/post-mount

chmod a+rx /jffs/scripts/*


echo '
#!/bin/sh
# Turn On Usage Of Swapfile
if [ -f "/dev/sda2" ];then
swapon /dev/sda2
echo "Turning Swapfile On"
fi
' >> /jffs/scripts/post-mount


大功告成。如果你对 swap 大小不满意请自行修改（注意 U 盘路径）。

附加

关于为什么 R7000 不能使用 OpenWRT？

OpenWRT 是支持 R7000 的，并且我也用过。我指的是无法正常使用路由器的功能，最重要的无线功能是无法启用的。原因是 R7000 的相关硬件的驱动是闭源的。如果你完全将其作为有线路由器来使用，OpenWRT 也未尝不可。

为什么 Merlin 可以让 R7000 使用无线？

因为华硕的一些路由器跟 R7000 用了同样的硬件，Merlin 有对应驱动的内核。但也因为如此，R7000 的 Merlin 内核一直处在 2.6 版本，这对于一个常更新的系统是一个很大的弊端。
 
为什么华硕不更新驱动支持新内核？

貌似很多人都有这个想法。但其实，驱动是对应厂商提供的，华硕也无能为力。在硬件不开源以及厂商不更新的情况下，可能只能把这个 2.6 内核使用下去。

2.6 这么旧的内核有什么短板？

目前很多公司生产环境 RH 系列的系统都是用的 2.6 内核，对于大多数情况而言是没有影响的。但是不排除有例如一些新元素不对旧内核进行支持的情况（例如高版本的 Docker、TCP-DDR 算法等）。当然，这种情况在嵌入式系统上概率会更小。

关于内核版本

在后续的了解中，我知道了原来 DD-WRT 是能在高版本内核（最新版已经是 4.4）中使用无线功能的。原因是 DD-WRT 和厂商有商业关系，所以解决了驱动问题。
于是我兴奋的去尝试了 DD-WRT，不得不说它是个非常优秀的路由器系统，有庞大的配置项。但可惜的是，我一直无法成功配置 Optware 或者 Entware 的环境。并且是由于一些莫名其妙的问题导致的，让人匪夷所思。例如，在 DD-WRT 的系统上，我无法执行生成的任何一个二进制可执行文件，这导致所有东西无法安装或者安装以后无法运行。

经过长时间的资料搜索，仍然无法解决。后来就刷回 Merlin 了，这也是我强烈推荐 Merlin 的原因。DD-WRT 可以一试，希望你们没有或者能解决我当时没能解决的问题。

UPDATE：DD 的所有问题已经解决，详情点击这里。

后续

后面还有解决 Ruby 的 gem、NodeJs 不兼容等问题和对 Lua 的推荐。以及一些有实际作用的应用，有时间会慢慢补充上来。

关于为什么只测试和使用脚本语言，因为 opkg 好像没有 Java，其他编译型语言需要交叉编译后上传二进制文件，麻烦，没特殊情况不会考虑使用。
