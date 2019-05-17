#/bin/bash
if [ -f "./ubunru_backup.tar.gz" ];then
mv  ubunru_backup.tar.gz /tmp/ubunru_backup.tar.gz \
tar -cvpzf /mnt/1/ubuntu_18.04.tar.gz \
--exclude=/ubuntu_18.04.tar.gz  \
--exclude=/data \
--exclude=/dev \
--exclude=/home \
--exclude=/media \
--exclude=/mnt \
--exclude=/cdrom \
--exclude=/proc \
--exclude=/run \
--exclude=/snap \
--exclude=/srv \
--exclude=/sys \
--exclude=/tmp \
--one-file-system /
fi

--exclude=proc \
--exclude=run \
--exclude=snap \
--exclude=srv \
--exclude=sys \
--exclude=tmp \
--exclude=dev \
--exclude=data \
--exclude=dev \
--exclude=media \
--exclude=cdrom \
--exclude=mnt \
--exclude=proc \
--exclude=run \
--exclude=snap \
--exclude=srv \
--exclude=sys \
--exclude=tmp \
--exclude=*.gz \
--exclude=*.deb \
--exclude=volume1 \ 
--exclude=rofs \
--one-file-system 
tar -cvpzf ../mnt/1/ubuntu_18.04.tar.gz \
--exclude=/data \
--exclude=/dev \
--exclude=/media \
--exclude=/cdrom \
--exclude=/mnt \
--exclude=/proc \
--exclude=/run \
--exclude=/snap \
--exclude=/srv \
--exclude=/sys \
--exclude=/tmp \
--exclude=*.gz \
--exclude=*.deb \
--exclude=/volume1 \ 
--exclude=/rofs \
--one-file-system /


tar -cvpzf /mnt/ubuntubk.tar.gz \
--exclude=data \
--exclude=dev \
--exclude=media \
--exclude=mnt \
--exclude=proc \
--exclude=run \
--exclude=srv \
--exclude=sys \
--exclude=tmp \
--exclude=*.gz \
--exclude=volume1 \
--exclude=initrd.img \
--exclude=initrd.img.old \
--exclude=vmlinuz \
--exclude=vmlinuz.old \
--one-file-system .

