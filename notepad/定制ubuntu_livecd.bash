定制Ubuntu安装CD

定制 CD
这是简体中文翻译，原文在这儿 [https://wiki.ubuntu.com/InstallCDCustomizationHowTo]


定制 Ubuntu CD 的过程并不复杂，但是她有一些繁琐和过分讲究。我对这过程所知并不完美，所以希望谁谁可以适当修改。


这安装 CD 有两个主要部分：一个 isolinux 上的操作系统，用来提供Debian安装程序的运行环境；一个 Debian 软件仓库，用来在光盘上放软件包和软件包索引。重建一个 CD 就包涵了这两部分的修改。


用 Presseed 文件修改安装行为

当这 CD 引导的时候，一个Linux内核启动和开始安装任务。这安装程序的行为可以用一个"preseed"文件来修改， 这些feeds会告诉Debian安装程序("d-i")如何回答debconf或其它的问题。如果您注意看你的安装CD，您会看见这些选项(例如 "server","expert","oem")都有对应的preseed文件。


所以，假设您想在相当多的相同配置机器上安装breezy，并且您知道如何回答这些安装时候会问的问题(您所在的国家和时区，您你的键盘布局，您的网络设置，您需要如何分区等等)。您可以 "preseed" 这些问题的回答在一个和简单的配置文件里。


用 isolinux.cfg 识别您的 preseed

首先，您必须告诉内核您的 preseed 文件的位置。在标准的光盘上有个目录 /preseed ；您可以把您的 seed 文件放这儿。您要修改 isolinux/isolinux.cfg 来告诉内核哪儿可以找到这文件，在文件 isolinux/isolinux.cfg 里。我的文件里有这些行


DEFAULT /install/vmlinuz
APPEND   preseed/file=/cdrom/preseed/learnexchange.seed kbd-chooser/method=us debian-installer/locale=en_CA vga=normal initrd=/install/initrd.gz ramdisk_size=16384 root=/dev/rd/0 DEBCONF_PRIORITY=critical debconf/priority=critical rw --

DEFAULT 是指我在 boot 提示符下直接按回车的情况。APPEND 包涵了要传给内核的参数。 preseed/file 是这儿最重要的；接着的那个指出我的将盘布局是加拿大；DEBCONF_PRIORITY 用来确定我不想看到不必要的 debconf 提问。


按您的情况小心修改这文件


写 preseed 文件

有很多例子可以用；这儿一个在安装盘里的 server.seed：


# Don't install usplash.
d-i     base-installer/kernel/linux/extra-packages-2.6  string
# Desktop system not installed; don't waste time and disk space copying it.
d-i     archive-copier/desktop-task     string ubuntu-standard
d-i     archive-copier/ship-task        string
# Only install the standard system and language packs in the second stage.
base-config     base-config/package-selection   string ~tubuntu-standard
base-config     base-config/language-pack-patterns      string language-pack-$LL
# No language support packages.
base-config     base-config/install-language-support    boolean false

首先注意格式，有 4 个部分：




指出是程序的那个部分
区段/命令
变量类型
变量值

两个要注意的地方：现在，d-i 期望有精确的类型和值；breezy 里的这个版本不支持用 \ 来处理多行(新的版本支持)。



我建议您从一些现有的 preseed 来修改，这儿有一个可以用的 http://archive.ubuntulinux.org/ubuntu/dists/breezy/main/installer-i386/current/doc/manual/en/apcs01.html. 如果您没能在这儿找到，那就试着执行这些命令


debconf-get-selections --installer > somefile.txt
debconf-get-selections >> somefile.txt

这会输出一个您在安装时候作出的选择的列表；这文件相当地长，并且实际上不那么适合用在安装盘里。特别是，NOTE: debconf-get-selections 会在类型和只之间放 2 个空格。您得在把她放在安装盘上以前修改他们。


如果您想让 d-i 安装额外的包，或一个最小的系统，您需要在 preseed 里修改 "base-config base-config/package-selection " 。 我想给她增加对孟加拉语和泰米尔语的支持，所以我用了这一行：


base-config  base-config/package-selection      string ~tubuntu-standard|~tubuntu-desktop|language-pack-gnome-bn|language-support-bn|language-pack-bn|language-support-bn|language-support-ta|language-pack-ta|language-pack-gnome-ta

修改 pool 目录，增加或删除一些包

或许是您主要想修改您的安装盘安装哪些包；特别是您想在 CD 里增加一些包。这有好几个方法来做到，不过我都不是完全地了解。最容易的事情是建立一个最小的仓库放您想要增加的包，再在制作光盘镜像文件以前合并到光盘文件里。这儿棘手的地方是：制作一个 Debian 本来就要安装的包；写一个更高版本的 Release 文件；并签上 GPG 。下面是我所做的。


. 选定一个文件目录作为您的工作空间；在这个目录里，

mkdir -p dists/breezy/extras/binary-i386 pool/extras/ isolinux preseed

把您修改过的 isolinux.cfg 放在目录 isolinux 里，把您的 preseed 文件放在目录 preseed 里。

. 把您需要的所有额外的包放在目录 pool/extras/ 里。您还需要包括一个新版本的 ubuntu-keyring 包，我将马上解释一下。

. 创建并编辑文件 dists/breezy/extras/binary-i386/Release ，写入

Archive: breezy
Version: 5.10
Component: extras
Origin: Ubuntu
Label: Ubuntu
Architecture: i386

. 把您做的修改合并到 CD 里

挂载您下载的官方 ISO 光盘镜像文件： mount /path/to/iso /some/mountpoint/ -o loop


b. 把光盘里的全部文件拷贝到某个目录(您会需要 1 到 2 G 的空间)；我用 rsync 来做： sudo rsync -azvb --delete --backup-dir=/yeowe/usr/cdbuilder/old/ $MOUNT $BUILD ( 这儿的 $MOUNT 是挂载点，$BUILD 是额外的包的目录)


c. 最重要的地方 。 我们将用 apt-ftparchive 工具来产生软件包和更高版本的 Release 文件。我们还要用 GPG 来签这个 Release 文件。安装程序会用包 ubuntu-keyring 里的公匙来检测签名。 但是您的签名不一样。所以您得建立一个新版本的 ubuntu-keyring 包。这做起来很容易

但是要确保正确无误。下面是执行的命令：

apt-get source ubuntu-keyring
cd ubuntu-keyring--2005.01.11/keyring
gpg --import < ubuntu-archive-keyring.gpg
gpg --list-keys "Your Name"
gpg --export  FBB75451 437D05B5 YOURKEYID > ubuntu-archive-keyring.gpg
cd ..
dpkg-buildpackage -rfakeroot -m"Your Name <your.email@your.host>
cp ubuntu-keyring*deb $BUILD/pool/extras/
ok -- what we've done here is import the 2 ubuntu keys into your main keyring, then exported them along with your own key into a replacement keyring. "YOURKEYID" should be replaced with the 8-digit hexadecimal code that gpg tells you when you do the --list-keys command above. And really, the best policy would be to do all that first, and copy a version into your $STAGE file structure so that you have it permanently available. 好了 -- 我们已经做了两个钥匙，可以把她们和您自己的钥匙一块替换进去。 "YOURKEYID" 会用 8 位的 16 进制数来替换。实际上，更好的方法是一开始就复制一份钥匙到您的 $STAGE 文件目录里去，以便一直有用。

. 现在就用 apt-ftparchive 来创建 Packages 和 Release 文件：
sudo apt-ftparchive packages  $BUILD/pool/extras/ > $BUILD/dists/breezy/extras/binary-i386/Packages

sudo apt-ftparchive -c $APTCONF release $BUILD/dists/breezy > $BUILD/dists/breezy/Release

apt-conf 是个看起来像这样的文件：

APT::FTPArchive::Release::Origin "Ubuntu";
APT::FTPArchive::Release::Label "Ubuntu";
APT::FTPArchive::Release::Suite "breezy";
APT::FTPArchive::Release::Version "5.10";
APT::FTPArchive::Release::Codename "breezy";
APT::FTPArchive::Release::Architectures "i386";
APT::FTPArchive::Release::Components "main restricted extras";
APT::FTPArchive::Release::Description "Ubuntu Breezy";

给 Release 文件签 gpg：

sudo gpg --output $BUILD/dists/breezy/Release.gpg -ba $BUILD/dists/breezy/Release

. 现在可以来生成光盘镜像文件：

sudo mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -hide-rr-moved -o $IMAGE -R $BUILD/

$IMAGE 表示您的光盘镜像文件

. 最后，可以用 cdrecord 或其它刻录工具来刻录您的 CD 了：

sudo nice -18 cdrecord dev=ATA:1,1,0 speed=12 --blank=fast -v -gracetime=2 -tao $IMAGE
that will burn the image on the second cd drive; if your cd-burner is the first or only cd-drive, change dev argument to ATA:1,0,0. I strongly recommend using rewritable media -- I've burned a LOT of coasters on this project.


好了，搞定！ 如果谁感兴趣，我写了一个小脚本(很简单)来自动完成这个步骤。我想我正好可以放在这儿


# usage 
# update-learningexchange.sh kubuntu|ubuntu|xubuntu

# a very primitive script with no structure of controls etc
# no default behaviour, etc etc
# all ofthis should be trivial to implement but my 
# bash syntax sucks
# obvious thing to do would be to conver to python 
# & add a simple gtk front end too
# but I'm rushed at the moment

# Notes;Bugs:
# REMEMBER: this absolutely will not work if you haven't built a new version of ubuntu-keyring 
# package & included that in $STAGE/pool/extras/!  You do that thusly:
# apt-get source ubuntu-keyring
# cd ubuntu-keyring-version-info/keyring
# gpg --import < ubuntu-server-keyring.gpg
# gpg --output=ubuntu-server-keyring.gpg --export "ubuntu" "Your Name"
# dpkg-buildpackage rfakeroot -m"My Name <my.email@my.hosts>"
# cp ../ubuntu-keyring*deb $BUILD/pool/extras/


# VARIABLES
# this script reles on the existence of several files and directories:

# Original = $ORIG: location of the "clean", unmodified cd .iso
# CD mount point = $MOUNT: mount point of clean cd
# Staging area = $STAGE: where you keep all your files
#   this area should include main dirs isolinux/, pool/, and dists/ at a minimum
#   as written the script assumes you have a directory pool/extras with your 
#   extra debs, and that dists/breezy/extras/binary-i386/Release exists (copy it over 
#   from dists/breezy/main/binary-i386, and replace "main" with "extras")
#   There is no doubt a better way to do this but it involves work...
# Building Area = $BUILD : location where your changes are merged into the "clean" directory s\
#   structure.
# Image location = $IMAGE: name of the new .iso file you want to build
# apt.conf file = $APTCONF: location of the file used to feed instructions to apt-ftparchive

ORIG="/var/www/jigdo/"$1"-breezy-install-i386.iso"
STAGE=/home/matt/LearningExchangeCD/$1/
MOUNT=/mnt/iso/
BUILD=/yeowe/usr/cdbuilder/$1
IMAGE="/yeowe/usr/cdbuilder/"$1"-learningexchange.iso"
APTCONF=/home/matt/LearningExchangeCD/apt.conf 


# sync with latest image
sudo umount $MOUNT
sudo mount $ORIG $MOUNT -o loop
# sudo rsync -azvb --delete --exclude="language-pack*" --backup-dir=/yeowe/usr/cdbuilder/old/ $MOUNT $BUILD
sudo rsync -azvb --delete  $MOUNT $BUILD
# now get rid of the old ubuntu-keyring package
sudo rm -r $BUILD/pool/u/ubuntu-keyring/
# note I've excluded a few files, shouldn't matter much for you I reckon
sudo rsync -avzb --exclude='*~' --exclude='INSTRUCTIONS.txt' --backup-dir=/yeowe/usr/cdbuilder/old/ --exclude='example-preseed.txt' $STAGE $BUILD

# generate Packages, Release, Release.gpg
# first thing to realize is, that we only need to generate the Packages files,
# the top-level Release file, and top-level  Release.gpg.  
# everything else should be in your $STAGE filestructure or usable unchanged 
# in the original form

# remove Release file otherwise you'll have trouble writing to it.  
sudo rm $BUILD/dists/breezy/Release*
# ubntu-keyring must be included in main/, so main NEEDS to be rebuilt!
# Need a for loop, "for x in [main,extras], do:".  
sudo apt-ftparchive packages  $BUILD/pool/main/ > $BUILD/dists/breezy/main/binary-i386/Packages
sudo apt-ftparchive packages  $BUILD/pool/extras/ > $BUILD/dists/breezy/extras/binary-i386/Packages
sudo apt-ftparchive -c $APTCONF release $BUILD/dists/breezy > $BUILD/dists/breezy/Release
# gpg optopns: -ba = armored, detached-sig
sudo gpg --output $BUILD/dists/breezy/Release.gpg -ba $BUILD/dists/breezy/Release

# build the actual image.  Note the options to mkisofs, which make the image bootable
sudo chown -R root:root $BUILD/isolinux  $BUILD/preseed 
sudo mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -hide-rr-moved -o $IMAGE -R $BUILD/

# burn the image to 2nd cd drive on most setups
sudo nice -18 cdrecord dev=ATA:1,1,0 speed=12 --blank=fast -v -gracetime=2 -tao $IMAGE