#!/bin/bash
if [ -z "$1" ]; then
       echo -e "usage: `basename $0` DISTRO
where DISTRO is the Ubuntu version codename (e.g. 16.04 is xenial)\n
The way to use this script is to do the changes to the repo first, i.e. delete or copy in the .deb file to /srv/packages/local-DISTRO, and then run this script\n
This script can be run as an unprivileged user - root is not needed so long as your user can write to the local repository directory"
else
    cd /mnt/d/repo-"$1"

    # Generate the Packages file
    dpkg-scanpackages packages /dev/null > Packages
    gzip --keep --force -9 Packages

    # Generate the Release file
    cat /mnt/d/config > Release
    # The Date: field has the same format as the Debian package changelog entries,
    # that is, RFC 2822 with time zone +0000
    echo -e "Date: `LANG=C date -Ru`" >> Release
    # Release must contain MD5 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
    echo -e 'MD5Sum:' >> Release
    printf ' '$(md5sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(md5sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
    # Release must contain SHA256 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
    echo -e '\nSHA256:' >> Release
    printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
    printf '\n '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
	#
	echo "MD5Sum:" >> Release
	md5sum Packages >> Release
	md5sum Packages.bz2 >> Release
	md5sum Packages.gz >> Release
	md5sum Release >> Release
	echo "SHA1:" >> Release
	sha1sum Packages >> Release
	sha1sum Packages.bz2 >> Release
	sha1sum Packages.gz >> Release
	sha1sum Release >> Release
	echo "SHA256:" >> Release
	sha256sum Packages >> Release
	sha256sum Packages.bz2 >> Release
	sha256sum Packages.gz >> Release
	sha256sum Release >> Release
	echo "SHA512:" >> Release
	sha512sum Packages >> Release
	sha512sum Packages.bz2 >> Release
	sha512sum Packages.gz >> Release
	sha512sum Release >> Release
    # Clearsign the Release file (that is, sign it without encrypting it)
    gpg --clearsign --digest-algo SHA512 --local-user  -o InRelease Release
    # # Release.gpg only need for older apt versions
    gpg -abs --digest-algo SHA512 --local-user -o Release.gpg Release

    # # Get apt to see the changes
    # sudo apt-get update
fi