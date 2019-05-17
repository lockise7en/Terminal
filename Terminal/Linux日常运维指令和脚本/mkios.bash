export ROOTFS=/rootfs
cd $ROOTFS
find | ( set -x; cpio -o -H newc | xz -9 --format=lzma --verbose --verbose --threads=0 --extreme ) > /tmp/iso/boot/initrd.img
cd -