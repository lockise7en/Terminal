#!/bin/bash

if [ -z "$1" ]; then
       echo -e "usage: `basename $0` DISTRO
where DISTRO is the Ubuntu version codename (e.g. 14.04 is trusty)\n
The way to use this script is to do the changes to the repo first, i.e. delete or copy in the .deb file to /srv/packages/local-DISTRO, and then run this script\n
This script can be run as an unprivileged user - root is not needed so long as your user can write to the local repository directory"
else
    cd /srv/packages/local-"$1"

    # Generate the Packages file
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
	# Release must contain SHA256 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
	echo -e '\nSHA1:' >> Release	
	printf ' '$(sha1sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha1sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha1sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	#
	echo -e '\nSHA256:' >> Release
	printf ' '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha256sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	#
	echo -e '\nSHA512:' >> Release
	printf ' '$(sha512sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha512sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha512sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

	
###binary-amd64

	echo -e 'MD5Sum:' >> Release	
	printf ' '$(md5sum dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages' $(wc --bytes dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(md5sum dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.gz' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(md5sum dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	# Release must contain SHA256 sums of all repository files (in a simple repo just the dists/bionic/stable/binary-amd64/Packages and dists/bionic/stable/binary-amd64/Packages.gz files)
	echo -e '\ nSHA1:' >> Release	
	printf ' '$(sha1sum dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages' $(wc --bytes dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha1sum dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.gz' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha1sum dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	#
	echo -e '\nSHA256:' >> Release
	printf ' '$(sha256sum dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages' $(wc --bytes dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha256sum dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.gz' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha256sum dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	#
	echo -e '\nSHA512:' >> Release
	printf ' '$(sha512sum dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages' $(wc --bytes dists/bionic/stable/binary-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha512sum dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.gz' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha512sum dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-amd64/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
# binary-i386
	echo -e 'MD5Sum:' >> Release	
	printf ' '$(md5sum dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages' $(wc --bytes dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(md5sum dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.gz' $(wc --bytes dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(md5sum dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	# Release must contain SHA256 sums of all repository files (in a simple repo just the dists/bionic/stable/binary-i386/Packages and dists/bionic/stable/binary-i386/Packages.gz files)
	echo -e '\ nSHA1:' >> Release	
	printf ' '$(sha1sum dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages' $(wc --bytes dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha1sum dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.gz' $(wc --bytes dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha1sum dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	#
	echo -e '\nSHA256:' >> Release
	printf ' '$(sha256sum dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages' $(wc --bytes dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha256sum dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.gz' $(wc --bytes dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha256sum dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
	#
	echo -e '\nSHA512:' >> Release
	printf ' '$(sha512sum dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages' $(wc --bytes dists/bionic/stable/binary-i386/Packages | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha512sum dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.gz' $(wc --bytes dists/bionic/stable/binary-i386/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
	printf '\n '$(sha512sum dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d dists/bionic/stable/binary-i386/Packages.bz2' $(wc --bytes dists/bionic/stable/binary-i386/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

			
	
echo -e 'MD5Sum:' >> Release	
printf ' '$(md5sum binary-amd64-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages' $(wc --bytes binary-amd64-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum binary-amd64-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages.gz' $(wc --bytes binary-amd64-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum binary-amd64-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages.bz2' $(wc --bytes binary-amd64-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

echo -e 'nSHA1:' >> Release	
printf ' '$(md5sums binary-amd64-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages' $(wc --bytes binary-amd64-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha1sum binary-amd64-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages.gz' $(wc --bytes binary-amd64-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha1sum binary-amd64-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages.bz2' $(wc --bytes binary-amd64-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

echo -e 'nSHA256:' >> Release	
printf ' '$(sha256sum binary-amd64-amd64/Packages | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages' $(wc --bytes binary-amd64-amd64/Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum binary-amd64-amd64/Packages.gz | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages.gz' $(wc --bytes binary-amd64-amd64/Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum binary-amd64-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d binary-amd64-amd64/Packages.bz2' $(wc --bytes binary-amd64-amd64/Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release


echo -e '\nSHA1:' >> Release
printf ' '$(sha1sum  Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha1sum  Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha1sum  Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release

echo -e '\nSHA256:' >> Release
printf ' '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha256sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release


# Clearsign the Release file (that is, sign it without encrypting it)
gpg --clearsign --digest-algo SHA512 -o InRelease Release
gpg -abs --digest-algo SHA512 -o Release.gpg Release

  gpg --clearsign --digest-algo SHA512 --local-user  -o InRelease Release
    # # Release.gpg only need for older apt versions
    gpg -abs --digest-algo SHA512 --local-user -o Release.gpg Release

gpg -abs --digest-algo SHA512 -o /volume1/lcd/custom-live-iso/dists/bionic/InRelease -ba /volume1/lcd/custom-live-iso/dists/bionic/Release

# Release.gpg only need for older apt versions
gpg -abs --digest-algo SHA128 -o Release.gpg Release
gpg -abs --digest-algo SHA512 --local-user lockyse7en -o /volume1/lcd/custom-live-iso/dists/bionic/Release.gpg -ba /volume1/lcd/custom-live-iso/dists/bionic/Release
    # Get apt to see the changes
    sudo apt-get update
fi

使用find 命令

find . -type f -print0 |xargs -0 md5sum >md5sum.txt

校验的话

md5sum -c a.md5
echo -e 'MD5Sum:' >> Release
find   -type f -print0 |xargs -0 md5sum | sort >> Release
find restricted/  -type f -print0 |xargs -0 md5sum | sort >> Release
find universe/  -type f -print0 |xargs -0 md5sum | sort >> Release
find multiverse/  -type f -print0 |xargs -0 md5sum | sort >> Release

echo -e 'nSHA1:' >> Release	
find   -type f -print0 |xargs -0 sha1sum | sort >> Release
find restricted/  -type f -print0 |xargs -0 sha1sum | sort >> Release
find universe/  -type f -print0 |xargs -0 sha1sum | sort >> Release
find multiverse/  -type f -print0 |xargs -0 sha1sum | sort >> Release

echo -e '\nSHA256:' >> Release
find   -type f -print0 |xargs -0 sha256sum | sort >> Release
find restricted/  -type f -print0 |xargs -0 sha256sum | sort >> Release
find universe/  -type f -print0 |xargs -0 sha256sum | sort >> Release
find multiverse/  -type f -print0 |xargs -0 sha256sum | sort >> Release
 

find /home -type f -print0 | xargs -0 md5sum | sort >md5.txt
查看当前目录下所有文件的 MD5 码：
find ./ -type f -print0 | xargs -0 md5sum | sort >md5.txt
$ fakeroot dpkg-buildpackage -b -us -uc # sudo will ask for a password to run the tests
$ sudo dpkg -i ../singularity-container_2.3_amd64.deb