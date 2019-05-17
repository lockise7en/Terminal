#!/bin/bash
tar -cpzf /volume2/18.04.tar.gz \
--exclude=/backup.tar.gz \
--exclude=/*deb \
--exclude=/proc \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/dev \
--exclude=/sys \
--exclude=/run \ 
--exclude=/media \
--exclude=/volume1
--exclude=/volume2 \
--exclude=/var/cache/apt-cacher-ng \
--exclude=/usr/share/nginx/www \
--exclude=/root/go \
--exclude=/home/fengshun/go \
--exclude=/var/cache/apt/archives \
--one-file-system /


 mksquashfs  / \
 --exclude=/volume1
 --exclude=/volume2 \
 --exclude=/var/cache/apt-cacher-ng \
 --exclude=/usr/share/nginx/www \
--exclude=/root/go \
--exclude=/home/fengshun/go \
/volume2/18.04.squashfs

 
tar -cvpzf /backup.tar.gz \
--exclude=/backup.tar.gz \
--exclude=*.tar.gz \
--exclude=*.tgz \
--exclude=/proc \
--exclude=/tmp \
--exclude=/mnt \
--exclude=/dev \
--exclude=/sys \
--exclude=/run \
--exclude=/media \
--exclude=/var/log \
--exclude=/var/cache/apt/archives \
--exclude=/usr/linux-headers* \
--exclude=/home \
--exclude=/recycle \
--exclude=/root \
--exclude=/var/tmp \
--one-file-system / 