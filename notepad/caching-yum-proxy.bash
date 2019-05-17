Caching YUM Proxy
I often need VMs with {minimal-centos} + {docker} for my learning experiments in my basement-lab. For example, an experimental Mesosphere DC/OS cluster requires 10+ nodes (one boot, three masters, five+ agents, one public-agent). I’ve automated the build process using ansible playbook & kickstart to make my life easier (just execute a shell script, and entire cluster-farm is ready in about 20 minutes).

So far so good – but a single iteration of such build makes over 550 URL requests and transfers about 300 MB files from various YUM repositories. That’s why I wrote this caching YUM proxy which considerably speeds up my build process. Also a respectful gesture to mirror-providers who donate their valuable resource to the community.

Here are the list of repo mapping that I needed.

http://centos.mirror.constant.com/7/os/x86_64/
mapped to => http://local.sudhaker.com/centos-7-os/

http://centos.mirror.constant.com/7/updates/x86_64/
mapped to => http://local.sudhaker.com/centos-7-updates/

http://centos.mirror.constant.com/7/extras/x86_64/
mapped to => http://local.sudhaker.com/centos-7-extras/

http://dl.fedoraproject.org/pub/epel/7/x86_64/
mapped to => http://local.sudhaker.com/epel-7/

http://yum.dockerproject.org/repo/main/centos/7/
mapped to => http://local.sudhaker.com/dockerproject/
And following nginx-configuration did the magic!

server {

    listen 3128;
    root /www/html/repo;

    location / {
        autoindex on;
        root               /www/html/repo/$host;
        error_page         404 = @fetch_proxy;
    }

    location @fetch_proxy {
        internal;
        resolver           192.168.1.1;
        proxy_pass         http://$host$uri;
        root               /www/html/repo/$host;
        proxy_store        on;
        proxy_store_access user:rw group:rw all:r;
        proxy_ignore_client_abort on;
    }
}

server {

    listen       80;
    server_name  local.sudhaker.com;
    root /www/html/repo;

    location / {
        autoindex on;
    }

    # http://centos.mirror.constant.com/7/os/x86_64/
    location /centos-7-os/ {
        autoindex on;
        proxy_pass http://127.0.0.1:3128/7/os/x86_64/;
        proxy_set_header Host centos.mirror.constant.com;
    }

    # http://centos.mirror.constant.com/7/updates/x86_64/
    location /centos-7-updates/ {
        autoindex on;
        proxy_pass http://127.0.0.1:3128/7/updates/x86_64/;
        proxy_set_header Host centos.mirror.constant.com;
    }

    # http://centos.mirror.constant.com/7/extras/x86_64/
    location /centos-7-extras/ {
        autoindex on;
        proxy_pass http://127.0.0.1:3128/7/extras/x86_64/;
        proxy_set_header Host centos.mirror.constant.com;
    }

    # http://dl.fedoraproject.org/pub/epel/7/x86_64/
    location /epel-7/ {
        autoindex on;
        proxy_pass http://127.0.0.1:3128/pub/epel/7/x86_64/;
        proxy_set_header Host dl.fedoraproject.org;
    }

    # http://yum.dockerproject.org/repo/main/centos/7/
    location /dockerproject/ {
        autoindex on;
        proxy_pass http://127.0.0.1:3128/repo/main/centos/7/;
        proxy_set_header Host yum.dockerproject.org;
    }

}
And kickstart has the following block for installation.

# Use local-network installation
url --url="http://local.sudhaker.com/centos-7-os"
repo --name="base" --baseurl=http://local.sudhaker.com/centos-7-os/
repo --name="updates" --baseurl=http://local.sudhaker.com/centos-7-updates/
And kickstart %post section contains the following block to make it stick after reboot.

rm -f /etc/yum.repos.d/*.repo
curl -s -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

cat > /etc/yum.repos.d/centos.repo << '__EOF__'
[base]
name=CentOS-$releasever - Base
baseurl=http://local.sudhaker.com/centos-7-os/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates
baseurl=http://local.sudhaker.com/centos-7-updates/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
baseurl=http://local.sudhaker.com/centos-7-extras/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=http://local.sudhaker.com/epel-7/
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
__EOF__
And a daily/weekly cron-job to ensure that the local cache is not stale.

# delete the local cahce of repodata
find /opt/nginx/html/repo/ -name repodata | xargs rm -fr