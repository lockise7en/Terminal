tar cvpzf 16.04.2-server-cloudimg-amd64-root.tar.gz X=@eaDir X=@recycle  X=/mnt X=/run  X=/sys  --one-file-system / 
tar xvpfz 16.04.2-server-cloudimg-amd64-root.tar.gz -C /

tar -cvpzf ubuntu.tgz X=@eaDir X=@recycle X=/mnt X=/sys  --one-file-system / 


tar cvpzf lede.tar.gz X=@eaDir X=@recycle  X=/mnt X=/sys  --one-file-system / X=/mnt 

 tar xvjf /mnt/gentoo/portage-latest.tar.bz2 -C /mnt/gentoo/usr
 tar -C /rootfs -cvf - . | tar -C /share -xf -
 tar -xvzf ubuntubk.tar.gz -C /

mkdir proc
mkdir lost+found
mkdir mnt
mkdir sys
/proc 权限：文件所有者：root群组：root 所有者：读取 执行 群组：读取 执行 其它：读取 执行
/lost+found 权限：文件所有者：root群组：root 所有者：读取 写入 执行 群组：读取 执行 其它：读取 执行
/mnt 权限：文件所有者：root群组：root 所有者：读取 写入 执行 群组：读取 执行 其它：读取 执行
/sys 权限：文件所有者：root群组：root 所有者：读取 写入 执行 群组：读取 执行 其它：读取 执行


du -sh originfile //先看看需要制作的源文件夹大小，假如15M

dd if=/dev/zero of=new_img.img bs=1024 count=86000 //生成20M的文件

dd if=/dev/sda of=/dev/sr0
mkfs.ext2 new_img.img
 tar -C .  -cvf  - . | tar -C /mnt/sdc/ubuntu -xf -
mount new_img.img /mnt/sda1/new

cp originfile /mnt/new -R
 tar -C /mnt  -cvf  - . | tar -C /volume1/ubuntu/ -xf -
ebs/libkdeclarative5_4%3a4.14.16-0ubuntu3.2_amd64.deb
./home/fengshun/新建文件夹/de
umount /mnt/new
 tar -C  /mnt/sdb -cvf - . | tar -C /mnt/sdc -xf -
// new_img.img文件里面就包括了originfile


mkdir -p /volume1/mnt/tmp/introot
mkdir -p /volume1/mnt/tmp/extroot
mount --bind /var/lib/docker /introot
mount lede extroot
tar -C /mnt/sda/1 -cvf - . | tar -C  /mnt/sdd/1/  -xf -
tar -C /mnt/sda/2 -cvf - . | tar -C  /mnt/sdd/2/  -xf -
tar -C /mnt/sda/3 -cvf - . | tar -C  /mnt/sdd/3/  -xf -
tar -C /volume2/v2/docker  -cvf - . | tar -C /volume1/v2/docker -xf -
tar -C  /volume2/v2/bitnami  -cvf - . | tar -C /volume1/v2  -xf -
umount introot
umount extroot

tar -cvpzf ../1/bionic_ubuntu.tar.gz \
--exclude=/bionic_ubuntu.tar.gz \
--exclude=/proc \
--exclude=/dev \
--exclude=*.deb \
--exclude=*.tgz \
--exclude=*.xz \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/run \
--exclude=/sys \
--exclude=/var/cache/apt/archives \
--exclude=/home/*/.gvfs \
--exclude=/home/*/.cache \
--exclude=/home/*/.local/share/Trash \
 --one-file-system /
 
tar -cvpzf ../1/bionic_ubuntu.tar.gz \
--exclude=proc \
--exclude=dev \
--exclude=*.deb \
--exclude=*.tgz \
--exclude=*.xz \
--exclude=tmp \
--exclude=mnt \
--exclude=run \
--exclude=sys \
--exclude=var/cache/apt/archives \
--exclude=home/*/.gvfs \
--exclude=home/*/.cache \
--exclude=home/*/.local/share/Trash \
 --one-file-system *

 /dev /dev/pts /proc /sys /run
 tar -cvpzf /ubuntubk.tar.gz \
 
--exclude=/ubuntubk.tar.gz \
--exclude=*.tar.gz \
--exclude=*.tgz \
--exclude=/proc \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/media \
--exclude=/var/log \
--exclude=/var/cache/apt/archives \
--exclude=/home \
--exclude=/root \
--exclude=/data \
--exclude=/temp \
--exclude=/cache \
--one-file-system / 




 
 
 