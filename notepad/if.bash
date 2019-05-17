ETH=$(eval "ifconfig | grep 'etho'| wc -l")
if [ "$ETH"  ==  '1' ] ; then
	nohup /usr/local/bin/net_speeder etho "ip" >/dev/null 2>&1 &
fi
if [ "$ETH"  ==  '0' ] ; then
    nohup /usr/local/bin/net_speeder virbr0 "ip" >/dev/null 2>&1 &
fi

#!/bin/sh

# Turn On Usage Of Swapfile
if [ -f "/dev/sdb1" ];then
swapon /dev/sdb1
echo "Turning Swapfile On"
fi

if [ ! -d /var/www/package ]; then
    mkdir -p /var/www/package
    sed -i '12s|DocumentRoot /var/www/html|DocumentRoot /var/www/package|' /etc/apache2/sites-enabled/000-default.conf

    # If user doesn't provide mirror.list, using default setting
    if [ ! -e /etc/apt/mirror.list ]; then
        echo "[$(date)] Using default mirror.list"
        ln -s /mirror.list /etc/apt/mirror.list
    fi
    create_link
fi

if [ ! -h "$dest" ] && [ x"$dest" != x"" ]; then
		echo "[$(date)] Create $dest"
		ln -s "/var/spool/apt-mirror/mirror/$mirror_path" "$dest"
fi 