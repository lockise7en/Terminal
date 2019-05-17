 rsync --exclude=/casper/filesystem.squashfs -a /tmp/livecd/ ~/livecd/cd
 for i in  /cdrom /volume2/mirrors/uburep/pool/Packages/disco;do mount -B $i /volume2/mirrors/casper/squashfs-root$i; done

 mount -o bind /mnt/sdb/stable/pool/stable squashfs-root/var/cache/apt/archives
 mount -o bind /volume2/mirrors/uburep/pool/Packages/disco  squashfs-root/var/cache/apt/archives
 
mount -o bind /run/ /target/run
mount --bind /dev/ /target/dev

chroot  /target
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devpts none /dev/pts
dpkg-divert --local --rename --add /sbin/initctl


umount /proc /run /dev/pts /sys /dev
rm -f /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl
exit

mksquashfs .  ../filesystem.squashfs
printf $(sudo du -sx --block-size=1 . | cut -f1) | sudo tee ../filesystem.size
sudo chroot . dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee ../filesystem.manifest
chroot . dpkg-query -W --showformat='${Package} \n' | sudo tee filesystem.manifest


cd ../ 
tar pzvcf filesystem.squashfs.tar.gz filesystem.squashfs filesystem.size filesystem.manifest

find . -type f -print0 |xargs -0 md5sum > md5sum.txt

	dpkg-scanpackages  disco /dev/null >  Packages
	dpkg-scanpackages pool/stable  /dev/null >  dists/disco/stable/Packages
	dpkg-scanpackages -a i386 pool/main /dev/null >  dists/stable/binary-i386/Packages
	    dpkg-scanpackages pool/main/stable /dev/null > dists/main/stable/Packages
    gzip --keep --force -9 Packages
		cp Packages  bk
		bzip2 --best Packages
		mv  bk Packages

    # Generate the Release file
    cp ../../../config Release

    # The Date: field has the same format as the Debian package changelog entries,
    # that is, RFC 2822 with time zone +0000
    echo -e "Date: `LANG=C date -Ru`" >> Release
    # Release must contain MD5 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
    echo -e 'MD5Sum:' >> Release
    printf ' '$(md5sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(md5sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(md5sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

    # Release must contain SHA256 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
    echo -e '\nSHA1:' >> Release
    printf ' '$(sha1sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha1sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha1sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

    # Release must contain SHA256 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
    echo -e '\nSHA256:' >> Release
    printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha256sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

    # Release must contain SHA256 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
    echo -e '\nSHA512:' >> Release
    printf ' '$(sha512sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha512sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha512sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

	#
	gpg --clearsign --digest-algo SHA512 -o InRelease Release
gpg -abs --digest-algo SHA512 -o Release.gpg Release

sudo find . -type f -print0 |xargs -0 md5sum > md5sum.txt
sudo mkisofs -r -V "Ubuntu-Budgie 19.04 amd64" -b isolinux/isolinux.bin -c isolinux/boot.cat -cache-inodes -J -l -no-emul-boot \
-boot-load-size 4 -boot-info-table -o ../ubuntu-budgie-19.04-desktop-amd64.iso .