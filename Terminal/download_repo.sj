#!/bin/bash
#apt-get update -y 
cat list |while read line
do
cd pool
apt-get download $line
done

#

cd ../

dpkg-scanpackages pool/ /dev/null > Packages
#
gzip --keep --force -9 Packages
bzip2 --keep --force -9 Packages

cat  /var/cache/apt/Release >> Release
#
echo -e "Date: `LANG=C date -Ru`" >> Release
#
echo -e 'MD5Sum:' >> Release
printf ' '$(md5sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release
# Release must contain SHA256 sums of all repository files (in a simple repo just the Packages and Packages.gz files)
echo -e '\nSHA256:' >> Release
printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum Packages.bz2 | cut --delimiter=' ' --fields=1)' %16d Packages.bz2' $(wc --bytes Packages.bz2 | cut --delimiter=' ' --fields=1) >> Release


# Clearsign the Release file (that is, sign it without encrypting it)
gpg --clearsign --digest-algo SHA512 --local-user lockyse7en -o InRelease Release
# Release.gpg only need for older apt versions
gpg -abs --digest-algo SHA512 --local-user lockyse7en -o Release.gpg Release
