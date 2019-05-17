#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
if [ -f /dev/sdb1 ]; then
	mount /dev/sdb1 /data
	if [ -f /data/cert/server.crt ]; then
	/usr/local/bin/docker-compose -f /home/harbor/src/harbor/docker-compose.yml up -d
	if
	if [ ! -d /data/cert/server.crt ]; then
	cp /home/harbor/src/data/* /data/ -R 
	/usr/local/bin/docker-compose -f /home/harbor/src/harbor/docker-compose.yml up -d
	if
fi

if [ -f /root/.lantern/bin/lantern ]; then
	nohup /root/.lantern/bin/lantern -headless true >/dev/null 2>&1 &
fi

if [ -f /volume1/opt/harbor/harbor_old/docker-compose.yml ]; then
	/usr/local/bin/docker-compose -f /volume1/opt/harbor/harbor_old/docker-compose.yml up -d
fi


exit 0
