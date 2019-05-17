
1.解压 initrd

# file initrd.`uname –r`.img （察看格式，不同的linux操作系统，这个文件格式也有不同，这个文件格式可能是cpio 也可能是ext2）

如果是cpio格式 ：
# mkdir /mnt/tmp
# cd /mnt/tmp
# cpio -idmv </tmp/initrd.`uname -r`.img

2 压缩initrd
2.1 mkinitrd
#cd /lib/modules/`uname -r`
#mkinitrd /tmp/initrd.`uname -r`.img   `uname -r`
#cd /tmp
#mv initrd.`uname –r`.img initrd.`uname –r`.img.gz(initrd使用gzip压缩，如果不改名字的话，后面无法解压缩)
#gunzip initrd.`uname -r`.img.gz

2.2 cpio
#假设当前目录位于准备好的initrd文件系统的根目录下
bash# find . | cpio -c -o > ../initrd.img
bash# gzip ../initrd.img

2.3  gen_init_cpio
获取 gen_init_cpio，工具 ，gen_init_cpio是编译内核时得到的，
在内核源代码的 usr 目录下，我们可以通过 以下步骤获取它，进入内核源代码 执行 ：
# make menuconfig
# make usr/
这样即编译好gen_init_cpio，
gen_initramfs_list.sh 在内核源代码的 script 目录下，
将这两个 文件 copy 到 /tmp 目录下，/tmp/initrd 为 解压好的 initrd 目录，执行以下命令 制作initrd ：

# gen_initramfs_list.sh initrd/ > filelist
# gen_init_cpio filelist >initrd.img
# gzip initrd.img
# mv initrd.img initrd-'uname –r’.img
只有用这个方式压缩的initrd ，在Linux系统重启的时候才能 一正确的文件格式 boot 起来，也可以用
这种方式修改安装光盘的initrd文件 然后 进行系统安装。

3. 如何在 initrd 中添加新的驱动，以 ahci.ko 为例
3.1 gen_init_cpio
# cp initrd-‘uname –r‘.img /tmp/initrd;cd /tmp/initrd
#cpio –ivdum < initrd-‘uname –r’.img;
# mv initrd-‘uname –r’.img ../
#cd /tmp/initrd
#vim init加上一行 insmod /lib/ahci.ko
#cp ahci.ko lib/
#cd  /tmp
# gen_initramfs_list.sh initrd/ > filelist
# gen_init_cpio filelist >initrd.img
# gzip initrd.img
# mv initrd.img initrd-‘uname –r’.img

至此，新的initrd文件initrd-‘uname –r’.img中就包含了ahci的驱动程序了 ，这种方式是最简单有效的。

3.2 mkinitrd
(1) Add “alias scsi_hostadapter ahci” at /etc/modprobe.conf
(2) copy ahci.ko to “/lib/module/$(kernel-version)”/kernel/drivers/scsi”
(3) mkinitrd initrd.img ‘uname -r’
至此，新的initrd文件initrd-‘uname –r’.img中就包含了ahci的驱动程序了 .