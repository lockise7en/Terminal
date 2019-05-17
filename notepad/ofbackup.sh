#!/bin/bash
####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 

# Where to backup to.
dest="/mnt/nfs/"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar --xattrs -czpvf /mnt/nfs/ububk/$hostname-$day.tgz \
--exclude=/proc \
--exclude=*.deb \
--exclude=*.tgz \
--exclude=*.xz \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/run \
--exclude=/var/cache/apt/archives \
--exclude=/usr/src/linux-headers* \
--exclude=/home/*/.gvfs \
--exclude=/home/*/.cache \
--exclude=/home/*/.local/share/Trash \
 --one-file-system / 
 
 
# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
