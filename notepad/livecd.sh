# usage 
# update-learningexchange.sh kubuntu|ubuntu|xubuntu

# a very primitive script with no structure of controls etc
# no default behaviour, etc etc
# all ofthis should be trivial to implement but my 
# bash syntax sucks
# obvious thing to do would be to conver to python 
# & add a simple gtk front end too
# but I'm rushed at the moment

# Notes;Bugs:
# REMEMBER: this absolutely will not work if you haven't built a new version of ubuntu-keyring 
# package & included that in $STAGE/pool/extras/!  You do that thusly:
# apt-get source ubuntu-keyring
# cd ubuntu-keyring-version-info/keyring
# gpg --import < ubuntu-server-keyring.gpg
# gpg --output=ubuntu-server-keyring.gpg --export "ubuntu" "Your Name"
# dpkg-buildpackage rfakeroot -m"My Name <my.email@my.hosts>"
# cp ../ubuntu-keyring*deb /volume1/lcd/custom-live-iso/pool/extras/


# VARIABLES
# this script reles on the existence of several files and directories:

# Original = $ORIG: location of the "clean", unmodified cd .iso
# CD mount point = $MOUNT: mount point of clean cd
# Staging area = $STAGE: where you keep all your files
#   this area should include main dirs isolinux/, pool/, and dists/ at a minimum
#   as written the script assumes you have a directory pool/extras with your 
#   extra debs, and that dists/bionic/extras/binary-amd64/Release exists (copy it over 
#   from dists/bionic/main/binary-amd64, and replace "main" with "extras")
#   There is no doubt a better way to do this but it involves work...
# Building Area = /volume1/lcd/custom-live-iso : location where your changes are merged into the "clean" directory s\
#   structure.
# Image location = $IMAGE: name of the new .iso file you want to build
# apt.conf file = $APTCONF: location of the file used to feed instructions to apt-ftparchive

ORIG="/home/fengshun/Downloads/"$1"-18.04.1-server-amd64.iso"
STAGE=/home/fengshun/LearningExchangeCD/$1/
MOUNT=/mnt/iso/
BUILD=/volume1/lcd/custom-live-iso/
IMAGE="/volume/usr/cdbuilder/"$1"-learningexchange.iso"
APTCONF=/home/fengshun/LearningExchangeCD/apt.conf 


# sync with latest image
sudo umount $MOUNT
sudo mount $ORIG $MOUNT -o loop
# sudo rsync -azvb --delete --exclude="language-pack*" --backup-dir=/volume/usr/cdbuilder/old/ $MOUNT /volume1/lcd/custom-live-iso
sudo rsync -azvb --delete  $MOUNT /volume1/lcd/custom-live-iso
# now get rid of the old ubuntu-keyring package
sudo rm -r /volume1/lcd/custom-live-iso/pool/u/ubuntu-keyring/
# note I've excluded a few files, shouldn't matter much for you I reckon
sudo rsync -avzb --exclude='*~' --exclude='INSTRUCTIONS.txt' --backup-dir=/volume/usr/cdbuilder/old/ --exclude='example-preseed.txt' $STAGE /volume1/lcd/custom-live-iso

# generate Packages, Release, Release.gpg
# first thing to realize is, that we only need to generate the Packages files,
# the top-level Release file, and top-level  Release.gpg.  
# everything else should be in your $STAGE filestructure or usable unchanged 
# in the original form

# remove Release file otherwise you'll have trouble writing to it.  
sudo rm /volume1/lcd/custom-live-iso/dists/bionic/Release*
# ubntu-keyring must be included in main/, so main NEEDS to be rebuilt!
# Need a for loop, "for x in [main,extras], do:".  
sudo apt-ftparchive packages  /volume1/lcd/custom-live-iso/pool/main/ > /volume1/lcd/custom-live-iso/dists/bionic/main/binary-amd64/Packages
sudo apt-ftparchive packages  /volume1/lcd/custom-live-iso/pool/extras/ > /volume1/lcd/custom-live-iso/dists/bionic/extras/binary-amd64/Packages
sudo apt-ftparchive -c /volume1/lcd/apt.conf release /volume1/lcd/custom-live-iso/dists/bionic > /volume1/lcd/custom-live-iso/dists/bionic/Release
# gpg optopns: -ba = armored, detached-sig
gpg -abs --digest-algo SHA512 --local-user lockyse7en -o /volume1/lcd/custom-live-iso/dists/bionic/InRelease -ba /volume1/lcd/custom-live-iso/dists/bionic/Release
gpg -abs --digest-algo SHA512 --local-user lockyse7en -o /volume1/lcd/custom-live-iso/dists/bionic/Release.gpg -ba /volume1/lcd/custom-live-iso/dists/bionic/Release


# build the actual image.  Note the options to mkisofs, which make the image bootable
sudo chown -R root:root /volume1/lcd/custom-live-iso/isolinux  /volume1/lcd/custom-live-iso/preseed 
sudo mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -hide-rr-moved -o $IMAGE -R /volume1/lcd/custom-live-iso/

# burn the image to 2nd cd drive on most setups
sudo nice -18 cdrecord dev=ATA:1,1,0 speed=12 --blank=fast -v -gracetime=2 -tao $IMAGE