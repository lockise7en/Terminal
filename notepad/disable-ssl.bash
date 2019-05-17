#!/bin/bash
grep -i -r "SSLProtocol" /opt/bitnami/apache2/conf >> /tmp/1
grep -i -r "SSLProtocol" /etc/apache2 >> /tmp/1
grep -i -r "SSLEngine" /etc/apache2 >> /tmp/2
grep -i -r "SSLEngine" /opt/bitnami/apache2/conf >> /tmp/2
#
cat /tmp/1 |while read line1
cat /tmp/2 |while read line2
#
read -r -p "Enable[e] or Disable[d] SSL support for Apache? [e/d] " input
case $input in
    [eE])
		echo "Enable SSL support for Apache"
		sed -i "s|SSLEngine off|SSLEngine on|g" $line1
		sed -i "s|#SSLProtocol|SSLProtocol|g"  $line1
		exit 0
		;;
    [dD]) 
		
		echo "Disable SSL support for Apache"
		sed -i "s|SSLEngine on|SSLEngine off|g"  $line1
		sed -i "s|SSLProtocol|#SSLProtocol|g"  $line1	
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