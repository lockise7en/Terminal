# synology
#!/bin/ash
alias  acme.sh=/opt/bitnami/acme.sh/acme.sh
alias  acme.sh=~/.acme.sh/acme.sh
alias acme.sh=/home/fengshun/.acme.sh/acme.sh
export CERT_FOLDER="$(find /etc/ca-certificates/system/default -maxdepth 1 -mindepth 1 -type d)"
export CERT_FOLDER="/etc/ssl/default"
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh  --issue --dns dns_ali  -d lockyse7en.com  -d *.lockyse7en.com  \
--installcert -d *.lockyse7en.com \
--cert-file '/etc/ssl/cert/cert.crt' \
--capath '/etc/ssl/cert/ca.crt' \
--key-file '/etc/ssl/cert/key.pem' \
--fullchain-file '/etc/ssl/cert/cert.pem'\
--key-file '/etc/ssl/cert/server.key' \
--fullchain-file '/etc/ssl/cert/server.crt'

--installcert -d *.lockyse7en.com \
--cert-file "/etc/ssl/default/" \
--capath "/etc/ssl/ca.crt" \
--key-file "/etc/ssl/ssl-cert-snakeoil.key" \
--fullchain-file "/etc/ssl/server-ca.crt" 

export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh  --issue --dns dns_ali  -d lockyse7en.com  -d *.lockyse7en.com  \
--installcert -d *.lockyse7en.com \
--cert-file /usr/syno/etc/ssl/ssl.crt/server.crt \
--key-file /usr/syno/etc/ssl/ssl.key/server.key \
--capath /usr/syno/etc/ssl/ssl.crt/ca.crt \
--fullchain-file /usr/syno/etc/ssl/ssl.intercrt/server-ca.crt

export CERT_FOLDER="$(find /usr/syno/etc/certificate/_archive/ -maxdepth 1 -mindepth 1 -type d)"
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh  --issue --dns dns_ali  -d lockyse7en.com  -d *.lockyse7en.com  \
--installcert -d *.lockyse7en.com \
--cert-file "$CERT_FOLDER/cert.pem" \
--key-file "$CERT_FOLDER/privkey.pem" \
--fullchain-file "$CERT_FOLDER/fullchain.pem" \
--capath "$CERT_FOLDER/chain.pem" \
--reloadcmd "/usr/syno/sbin/synoservicectl --reload nginx" \
--dnssleep 20


--cert-file /usr/syno/etc/ssl/ssl.crt/server.crt \
--key-file /usr/syno/etc/ssl/ssl.key/server.key \
--fullchain-file /usr/syno/etc/ssl/ssl.intercrt/server-ca.crt

export NGINX_CERT_FOLDER="/etc/nginx/cert"
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh  --issue --dns dns_ali  -d lockyse7en.com  -d *.lockyse7en.com  \
--installcert -d *.lockyse7en.com \
--cert-file "$NGINX_CERT_FOLDER/cert.crt" \
--capath "$NGINX_CERT_FOLDER/ca.crt" \
--key-file "$NGINX_CERT_FOLDER/server.key" \
--fullchain-file "$NGINX_CERT_FOLDER/server.crt"
alias  acme.sh=~/.acme.sh/acme.sh
export BITNAMI_CERT_FOLDER='/bitnami/webmin/conf/cert'
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh  --issue --dns dns_ali  -d lockyse7en.com  -d *.lockyse7en.com  \
--installcert -d *.lockyse7en.com \
--cert-file "$BITNAMI_CERT_FOLDER/cert.crt" \
--capath "$BITNAMI_CERT_FOLDER/ca.crt" \
--key-file "$BITNAMI_CERT_FOLDER/server.key" \
--fullchain-file "$BITNAMI_CERT_FOLDER/server.crt" 

Your cert is in  /root/.acme.sh/lockyse7en.com/lockyse7en.com.cer
Your cert key is in  /root/.acme.sh/lockyse7en.com/lockyse7en.com.key
he intermediate CA cert is in  /root/.acme.sh/lockyse7en.com/ca.cer
And the full chain certs is there:  /root/.acme.sh/lockyse7en.com/fullchain.cer

SSLCertificateFile    /etc/ssl/certs/ssl-cert-snakeoil.pem
SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
SSLCertificateChainFile /etc/ssl/certs/server-ca.crt


\
--key-file   /etc/apache2/ssl/server.key \
--fullchain-file /etc/apache2/ssl/server.crt \
--cert-file /usr/syno/etc/certificate/system/default/cert.pem \
--key-file /usr/syno/etc/certificate/system/default/privkey.pem \
--fullchain-file /usr/syno/etc/certificate/system/default/fullchain.pem \
--capath /usr/syno/etc/certificate/system/default/ca.crt \
--key-file /usr/syno/etc/certificate/system/default/privkey.pem \ #(ca-cert)
--fullchain-file /usr/syno/etc/certificate/system/default/fullchain.pem \

--domain-key-file "$CERT_FOLDER/domain.key"



#!/bin/bash
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh --issue --dns dns_ali  -d lockyse7en.com  -d '*.lockyse7en.com' --nginx  --apache --force \
--installcert  -d  bt.lockyse7en.com  \
--key-file   /etc/apache2/ssl/server.key \
--fullchain-file /etc/apache2/ssl/server.crt \
--key-file   /www/server/panel/ssl/lockyse7en.com.key \
--fullchain-file /www/server/panel/ssl/lockyse7en.com.cer

		
AccessKeyID LTAILea8DBK9q6VC
AccessKeySecret a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh --issue --dns dns_ali  -d lockyse7en.com  -d '*.lockyse7en.com' --debug --nginx --force --debug \
--cert-file /usr/syno/etc/certificate/system/default/cert.pem \
--key-file /usr/syno/etc/certificate/system/default/privkey.pem \
--fullchain-file /usr/syno/etc/certificate/system/default/fullchain.pem \
--reloadcmd "/usr/syno/sbin/synoservicectl --reload nginx" \
--dnssleep 20		
        --reloadcmd  "service nginx force-reload"
		
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh --issue --dns dns_ali  -d fcylove.com  -d '*.fcylove.com' --nginx  --apache --force 		
fcylove.com

acme.sh  --installcert  -d  gaming.lockyse7en.com   \
        --key-file   /data/ssl/server.key \
        --fullchain-file /data/ssl/server.cer \
        --reloadcmd  "service nginx force-reload"
lnmp dnsssl ali --dns dns_ali   -d lockyse7en.com  -d *.lockyse7en.com
Apache example:

acme.sh --install-cert -d example.com \
--cert-file      /path/to/certfile/in/apache/cert.pem  \
--key-file       /path/to/keyfile/in/apache/key.pem  \
--fullchain-file /path/to/fullchain/certfile/apache/fullchain.pem \
--reloadcmd     "service apache2 force-reload"
Nginx example:

acme.sh --install-cert -d example.com \
--key-file       /path/to/keyfile/in/nginx/key.pem  \
--fullchain-file /path/to/fullchain/nginx/cert.pem \
--reloadcmd     "service nginx force-reload"

	export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh  --issue --dns dns_ali  -d lockyse7en.com  -d '*.lockyse7en.com'  \
--installcert -d 'gitlab.lockyse7en.com' \
--create-domain-key \
export DEPLOY_SSH_KEYFILE="$CERT_FOLDER/privkey.pem"
export DEPLOY_SSH_CERTFILE="$CERT_FOLDER/cert.pem"
export DEPLOY_SSH_CAFILE="$CERT_FOLDER/chain.pem"
export DEPLOY_SSH_FULLCHAIN="$CERT_FOLDER/fullchain.pem"
	
	
	
acme.sh --deploy -d "lockyse7en.com"  --deploy-hook ssh \
	--cert-file "$CERT_FOLDER/cert.pem" \
	--key-file "$CERT_FOLDER/privkey.pem" \
	--fullchain-file "$CERT_FOLDER/fullchain.pem" \
	--capath "$CERT_FOLDER/chain.pem" 

export CERT_FOLDER="/etc/ca-certificates/system/default"
# Make sure "$CERT_FOLDER is only one name. Else you have to manually specify the folder.
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
export DEPLOY_SSH_USER="root"  # required
export DEPLOY_SSH_SERVER="nas.lockyse7en.com"  # defaults to domain name
export DEPLOY_SSH_KEYFILE="$CERT_FOLDER/privkey.pem"
export DEPLOY_SSH_CERTFILE="$CERT_FOLDER/cert.pem"
export DEPLOY_SSH_CAFILE="$CERT_FOLDER/chain.pem"
export DEPLOY_SSH_FULLCHAIN="$CERT_FOLDER/fullchain.pem"
export DEPLOY_SSH_REMOTE_CMD="/usr/bin/sshd restart"
export DEPLOY_SSH_BACKUP="yes" 
acme.sh --deploy -d "*.lockyse7en.com"  --deploy-hook ssh


#
export DEPLOY_SSH_USER="root"
export DEPLOY_SSH_KEYFILE="$CERT_FOLDER/privkey.pem"
export DEPLOY_SSH_FULLCHAIN="$CERT_FOLDER/fullchain.pem"
export DEPLOY_SSH_REMOTE_CMD="openssl pkcs12 -export \
   -inkey "$CERT_FOLDER/privkey.pem" \
   -in "$CERT_FOLDER/fullchain.pem" \
   -out "$CERT_FOLDER/openssl.p12" \
   -name ubnt -password root:y \
 && keytool -importkeystore -deststorepass aircontrolenterprise \
   -destkeypass aircontrolenterprise \
   -destkeystore /var/lib/unifi/keystore \
   -srckeystore /var/lib/unifi/unifi.example.com.p12 \
   -srcstoretype PKCS12 -srcstorepass temppass -alias ubnt -noprompt \
 && service unifi restart"

acme.sh --deploy -d unifi.example.com --deploy-hook ssh


export DEPLOY_SSH_USER="root"
export DEPLOY_SSH_SERVER="nas.lockyse7en.com"
export DEPLOY_SSH_KEYFILE="/root/.acme.sh/lockyse7en.com/lockyse7en.com.key"
export DEPLOY_SSH_CERTFILE="/root/.acme.sh/lockyse7en.com/ca.cer"
export DEPLOY_SSH_CAFILE=filename for intermediate CA file
export DEPLOY_SSH_FULLCHAIN="/root/.acme.sh/lockyse7en.com/fullchain.cer"
acme.sh --deploy -d lockyse7en.com --deploy-hook ssh

export CERT_FOLDER="$(find /usr/syno/etc/certificate/_archive/ -maxdepth 1 -mindepth 1 -type d)"
# Make sure $CERT_FOLDER is only one name. Else you have to manually specify the folder.
export Ali_Key='LTAILea8DBK9q6VC'
export Ali_Secret='a1jgMUz8ZY0um9Vpzn4UugqWAD8eHi'
acme.sh --issue --dns dns_ali  -d lockyse7en.com  -d '*.lockyse7en.com'  \
	--installcert -d '*.lockyse7en.com' \
	--cert-file "$CERT_FOLDER/cert.pem" \
	--key-file "$CERT_FOLDER/privkey.pem" \
	--fullchain-file "$CERT_FOLDER/fullchain.pem" \
	--capath "$CERT_FOLDER/chain.pem" \
	--reloadcmd "/usr/syno/sbin/synoservicectl --reload nginx" \
	--dnssleep 20