#!/bin/bash
read -r -p "Enable or Disable SSL support for Apache? [ON/OFF] " input
case $input in
    [oO])
		echo "Enable SSL support for Apache"
		sed -i "s|SSLEngine off|SSLEngine on|g" apache2/conf/bitnami/bitnami.conf
		sed -i "s|SSLEngine off|SSLEngine on|g" apache2/conf/extra/httpd-ssl.conf
		sed -i "s|SSLEngine off|SSLEngine on|g" apache2/conf/original/extra/httpd-ssl.conf
		exit 0
		;;
    [fF]) 
		
		echo "Disable SSL support for Apache"
		sed -i "s|SSLEngine on|SSLEngine off|g" apache2/conf/bitnami/bitnami.conf
		sed -i "s|SSLEngine on|SSLEngine off|g" apache2/conf/extra/httpd-ssl.conf
		sed -i "s|SSLEngine on|SSLEngine off|g" apache2/conf/original/extra/httpd-ssl.conf
		exit 0
       		;;

    [qQ])
		echo "No"
       		;;

    *)
	echo "Invalid input..."
	exit 1
	;;
esac