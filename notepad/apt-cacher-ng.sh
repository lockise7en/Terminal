#!/bin/bash 
if [ -f /var/cache/apt-cacher-ng ]; then
	chmod -R 0755 /var/cache/apt-cacher-ng
	chown -R apt-cacher-ng:root /var/cache/apt-cacher-ng
	/etc/init.d/apt-cacher-ng start
fi
