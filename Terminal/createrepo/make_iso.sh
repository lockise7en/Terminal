#!/bin/sh
set -e

# Ensure init system invokes /opt/shutdown.sh on reboot or shutdown.
#  1) Find three lines with `useBusyBox`, blank, and `clear`
#  2) insert run op after those three lines
sed -i "1,/^useBusybox/ { /^useBusybox/ { N;N; /^useBusybox\n\nclear/ a\
\\\n\
# Run boot2docker shutdown script\n\
test -x \"/opt/shutdown.sh\" && /opt/shutdown.sh\n
} }" $ROOTFS/etc/init.d/rc.shutdown
# Verify sed worked
grep -q "/opt/shutdown.sh" $ROOTFS/etc/init.d/rc.shutdown || ( echo "Error: failed to insert shutdown script into /etc/init.d/rc.shutdown"; exit 1 )

# Make some handy symlinks (so these things are easier to find)
ln -fs /var/lib/boot2docker/docker.log $ROOTFS/var/log/
ln -fs /usr/local/etc/init.d/docker $ROOTFS/etc/init.d/

# Setup /etc/os-release with some nice contents
b2dVersion="$(cat $ROOTFS/etc/version)" # something like "1.1.0"
b2dDetail="$(cat $ROOTFS/etc/boot2docker)" # something like "master : 740106c - Tue Jul 29 03:29:25 UTC 2014"
tclVersion="$(cat $ROOTFS/usr/share/doc/tc/release.txt)" # something like "5.3"
cat > $ROOTFS/etc/os-release <<-EOOS
NAME=Boot2Docker
VERSION=$b2dVersion
ID=boot2docker
ID_LIKE=tcl
VERSION_ID=$b2dVersion
PRETTY_NAME="Boot2Docker $b2dVersion (TCL $tclVersion); $b2dDetail"
ANSI_COLOR="1;34"
HOME_URL="http://boot2docker.io"
SUPPORT_URL="https://github.com/boot2docker/boot2docker"
BUG_REPORT_URL="https://github.com/boot2docker/boot2docker/issues"
EOOS

# Pack the rootfs
cd $ROOTFS
find | ( set -x; cpio -o -H newc | xz -9 --format=lzma --verbose --verbose --threads=0 --extreme ) > /tmp/iso/boot/initrd.img
cd -

# Make the ISO
# Note: only "-isohybrid-mbr /..." is specific to xorriso.
# It builds an image that can be used as an ISO *and* a disk image.
xorriso  \
    -publisher "Docker Inc." \
    -as mkisofs \
    -l -J -R -V "b2d-v$(cat $ROOTFS/etc/version)" \
    -no-emul-boot -boot-load-size 4 -boot-info-table \
    -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat \
    -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
    -o /boot2docker.iso /tmp/iso
sudo mkisofs -r -V "Ubuntu-Budgie 19.04 amd64" \
-b isolinux/isolinux.bin \
-c isolinux/boot.cat \
-cache-inodes \
-J -l -no-emul-boot \
-boot-load-size 4 \
-e boot/grub/efi.img \
-boot-info-table \
-allow-limited-size \
-eltorito-alt-boot \
-o ../ubuntu-budgie-19.04-desktop-amd64.iso .

 -U -A "Custom1404" -V "Custom1404" \
 -volset "Custom1404" -J -joliet-long -r -v -T -o \
 ../Custom1404.iso \
 -b isolinux/isolinux.bin \
 -c isolinux/boot.cat \
 -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot .
		
sudo mkisofs -D -r \
-V "non-efi-ubuntu" \
-cache-inodes -J -l \
-b isolinux/isolinux.bin \
-c isolinux/boot.cat \
-no-emul-boot \
-boot-load-size 4 \
-boot-info-table -o \
../non-efi-ubuntu.iso 		

sudo mkisofs -U \
-A "ubuntu-budgie-19.04-desktop-amd64.iso" \
-V "Ubuntu-Budgie 19.04 amd64" \
-volset "ubuntu-budgie-19.04-desktop-amd64.iso" \
-J -joliet-long -r -v -T \
-o ../ubuntu-budgie-19.04-desktop-amd64.iso.iso \
-b isolinux/isolinux.bin \
-c isolinux/boot.cat \
-no-emul-boot \
-boot-load-size 4 \
-boot-info-table \
-eltorito-alt-boot \
-e boot/grub/efi.img \
-no-emul-boot .