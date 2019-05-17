#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
###========registry ctl start======================================###
do_start() {
	if [ -f /bin/registry ]; then
		nohup /bin/registry serve /etc/docker/registry/config.yml >/dev/null 2>&1 &
		echo "registry serve runing"
	fi
}
do_stop() {
	kill $(pgrep -l registry)
	echo "registry serve stoped"
}
do_restart() {
	echo "registry serve stoped"
	
	kill $(pgrep -l registry)
	
	echo "registry serve runing"
	nohup /bin/registry serve /etc/docker/registry/config.yml >/dev/null 2>&1 &
}
do_status() {
		pgrep -l registry
}

do_help() {
echo "registry serve {start|stop|status|restart}"
}

case "$1" in
    help)
	do_help
	exit 1
	;;
    start)
	do_start
	exit 1
	;;
    stop)
	do_stop		
	exit 1
	;;
	status)
	do_status		
	exit 1
	;;
	restart)
	do_restart
	exit 1
    exit 0
    ;;
esac
###========registry ctl end======================================###
###========lantern ctl start======================================###
do_start() {
	if [ -f /root/.lantern/bin/lantern ]; then
		nohup /root/.lantern/bin/lantern -headless true >/dev/null 2>&1 &
		echo "lantern serve runing"
	fi
}
do_stop() {
	kill $(pgrep -l lantern)
	echo "lantern serve stoped"
}
do_restart() {
	echo "lantern serve stoping"
	
	kill $(pgrep -l lantern)
	
	echo "lantern serve runing"
	nohup /root/.lantern/bin/lantern -headless true >/dev/null 2>&1 &
}
do_status() {
		pgrep -l lantern
}
do_help() {
echo "lantern serve {start|stop|status|restart}"
}
case "$1" in
    help)
	do_help
	exit 1
	;;
    start)
	do_start
	exit 1
	;;
    stop)
	do_stop		
	exit 1
	;;
	status)
	do_status		
	exit 1
	;;
	restart)
	do_restart
	exit 1
    exit 0
    ;;
esac
###========lantern ctl end======================================###