 #!/bin/bash
 umask 22
 mkdir /mnt/f/rootfs
 cd /mnt/f/rootfs
mkdir cache data dev home media mnt opt proc root run snap srv sys tmp

 /dev /dev/pts /proc /sys /run
chmod 1777 tmp
cp -a /b* /etc /l* /sbin /usr /var /root .
tar cvpf ../rootfs.tar *
xz -9 ../rootfs.tar
cd /mnt/f
tar cvpf root.tar /root
tar cvpf home.tar /home
exit