sudo mount /dev/sda2 /mnt 

sudo mount /dev/sda1 /mnt/boot/efi
mount /dev/sda1 /boot/efi
sudo mount --bind /dev /mnt/dev &&
sudo mount --bind /dev/pts /mnt/dev/pts &&
sudo mount --bind /proc /mnt/proc &&
sudo mount --bind /sys /mnt/sys

sudo mount /dev/sdXXX /mnt
sudo mount /dev/sdXY /mnt/boot
sudo mount /dev/sdXX /mnt/boot/efi
mount /dev/sda1  /mnt/boot/efi
for i in /dev/pts /dev /proc /sys /run; do sudo mount -B $i /cdrom/casper/squashfs-root$i; done

for i in dev proc sys run; do sudo mount -B $i /mnt/$i; done

sudo chroot /mnt
grub-install /dev/sda
update-grub 
grub-install --target=x86_64-efi /dev/sda

grub-install --recheck /dev/sda
 for i in /dev /dev/pts /proc /sys /run; do sudo umount /cdrom/casper/squashfs-root$i; done


for m in  /mnt/dev/pts /mnt/dev /mnt/proc /mnt/sys /mnt/run /mnt/boot/efi /mnt; do sudo umount  $m ; done
for i in /mnt/sda/2/dev /mnt/sda/2/proc /mnt/sda/2/sys /mnt/sda/2/run;  umount  $i ; done
/dev
/proc /sys /run