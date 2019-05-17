
原创 基于httpd-2.4配置虚拟主机web站点，并提供https服务（一）
花火殊途2018.04.27阅 223
“版权声明：原创作品，如需转载，请注明出处。否则将追究法律责任
 使用httpd-2.2和httpd-2.4实现

> 1.建立httpd服务，要求：

> 1) 提供两个基于名称的虚拟主机www1, www2；要求每个虚拟主机都有单独的错误日志和访问日志； 

> 2) 通过www1的/server-status提供状态信息，且仅允许172.16.0.1主机访问；

> 3) www2不允许192.168.1.0/24网络中任意主机访问；

> 2.为上面的第2)个虚拟主机提供https服务。

> 



基于httpd-2.4配置虚拟主机web站点，并提供https服务：

1.准备：（1）在VMwareWorkstation平台下的CentOS7.2一枚；（2）真实机客户端一个；

2.环境：（1）CentOS7.2系统中安装httpd应用程序并启动httpd服务；（2）关闭防火墙；（3）设置SELinux；

（1） [root@chenliang ~]# yum -y install httpd

  [root@chenliang ~]# systemctl restart http.service

  Active: active (running)

（2） [root@chenliang ~]# iptables -F

（3） [root@chenliang ~]# setenforce 0

3.操作步骤：


[root@chenliang ~]# cd /etc/httpd/conf.d

创建两个基于主机名的web站点：

[root@chenliang conf.d]# vim www1.conf



<VirtualHost 172.16.72.1:80>

        ServerName www1.cl7.com

        DocumentRoot /var/www/www1

        ErrorLog logs/www1-error_log

        CustomLog logs/www1-access_log combined



        <Location /server-status>

        SetHandler server-status

        Require all denied            //httpd-2.4中统一使用Require来允许或阻止客户端主机访问,只要没有明确的指明允许哪些客户端主机访问，则拒绝所有客户端主机访问;

        Require ip 172.16.0.1

        </Location>



</VirtualHost>



[root@chenliang conf.d]# vim www2.conf

<VirtualHost 172.16.72.1:80>

        ServerName www2.cl7.com

        DocumentRoot "/var/www/www2"

        ErrorLog logs/www2-error_log

        CustomLog logs/www2-access_log combiend

    <Directory "/var/www/www2">

        Options None

        AllowOverride None

        <RequireAll>                                     //如果允许和拒绝等访问控制要同时设置，则所有的Require指令必须要放置在<RequireAny>或者<RequireAll>容器指令中

                Require not ip 192.168.1.0/24

                Require all granted                     

        </RequireAll>

    </Directory>

</VirtualHost>



检查创建的虚拟主机语法有没有错误：

[root@chenliang conf.d]# httpd -t

AH00557: httpd: apr_sockaddr_info_get() failed for chenliang

AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message

Syntax OK

创建路径映射目录：

[root@chenliang conf]# mkdir -pv /var/www/www{1,2}

mkdir: 已创建目录 "/var/www/www1"

mkdir: 已创建目录 "/var/www/www2"

[root@chenliang conf]# echo "WWW1's page~~" > /var/www/www1/index.html

[root@chenliang conf]# echo "WWW2's page~~" > /var/www/www2/index.html

添加域名解析：

[root@chenliang conf.d]# echo "172.16.72.1 www1.cl.com www2.cl.com" >> /etc/hosts

重启httpd服务：

[root@chenliang conf.d]# systemctl restart httpd.service

在真实机端打开系统盘：C:\Windows\System32\drivers\etc\hosts，使用文本编辑器编辑添加并保存添加内容：172.16.72.1 www1.cl7.com www2.cl7.com

使用客户端测试结果如下：

1.png

 

2.png



测试www1是否能允许172.16.0.1网段内的主机查看服务器属性：

3.png



4.为虚拟主机www2提供https服务：

   （1） 创建私有CA：

            1）生成私钥：

            [root@chenliang ~]# cd /etc/pki/CA

            [root@chenliang CA]# ls

            certs  crl  newcerts  private

            [root@chenliang CA]# (umask 077; openssl genrsa -out private/cakey.pem 4096)

            Generating RSA private key, 4096 bit long modulus

            ............................................................................................................................................................++

            .....................................................................................................................................................................................................................................................++

            e is 65537 (0x10001)

            2）生成自签证书：

            [root@chenliang CA]# openssl req -new -x509 -key private/cakey.pem -out cacert.pem

            You are about to be asked to enter information that will be incorporated

            into your certificate request.

            What you are about to enter is what is called a Distinguished Name or a DN.

            There are quite a few fields but you can leave some blank

            For some fields there will be a default value,

            If you enter '.', the field will be left blank.

            -----

            Country Name (2 letter code) [XX]:CN

            State or Province Name (full name) []:Hebei

            Locality Name (eg, city) [Default City]:Handan

            Organization Name (eg, company) [Default Company Ltd]:chenliang

            Organizational Unit Name (eg, section) []:chenliang

            Common Name (eg, your name or your server's hostname) []:chenliang

            Email Address []:

            

            [root@chenliang CA]# ls

            cacert.pem  certs  crl  newcerts  private

            3）将文本文件和目录添加完成私有CA配置：

            [root@chenliang CA]# touch index.txt

            [root@chenliang CA]# echo 01 > serial

    （2）创建https站点：{前提要安装httpd模块列表中的mod_ssl模块}  

 1）生成私钥并生成证书请求：

[root@chenliang ~]# mkdir -pv /etc/httpd/ssl

mkdir: 已创建目录 "/etc/httpd/ssl"

[root@chenliang ~]# cd /etc/httpd/ssl

[root@chenliang ssl]# ls

[root@chenliang ssl]# (umask 077;openssl genrsa -out httpd.key 4096)

Generating RSA private key, 4096 bit long modulus

...............................++

......................++

e is 65537 (0x10001)

[root@chenliang ssl]# openssl req -new -key httpd.key -out httpd.csr

You are about to be asked to enter information that will be incorporated

into your certificate request.

What you are about to enter is what is called a Distinguished Name or a DN.

There are quite a few fields but you can leave some blank

For some fields there will be a default value,

If you enter '.', the field will be left blank.

-----

Country Name (2 letter code) [XX]:CN

State or Province Name (full name) []:Hebei

Locality Name (eg, city) [Default City]:Handan

Organization Name (eg, company) [Default Company Ltd]:chenliang

Organizational Unit Name (eg, section) []:chenliang

Common Name (eg, your name or your server's hostname) []:chenliang

Email Address []:



Please enter the following 'extra' attributes

to be sent with your certificate request

A challenge password []:123456

An optional company name []:CL

[root@chenliang ssl]# ls

httpd.csr  httpd.key

2）将证书请求发送到CA：

[root@chenliang ssl]# cp httpd.csr /tmp/        

3）在CA上为此次请求签发证书：

[root@chenliang ssl]# openssl ca -in /tmp/httpd.csr -out /etc/pki/CA/certs/httpd.crt

Using configuration from /etc/pki/tls/openssl.cnf

Check that the request matches the signature

Signature ok

Certificate Details:

        Serial Number: 1 (0x1)

        Validity

            Not Before: Apr 27 12:51:29 2018 GMT

            Not After : Apr 27 12:51:29 2019 GMT

        Subject:

            countryName               = CN

            stateOrProvinceName       = Hebei

            organizationName          = chenliang

            organizationalUnitName    = chenliang

            commonName                = chenliang

        X509v3 extensions:

            X509v3 Basic Constraints: 

                CA:FALSE

            Netscape Comment: 

                OpenSSL Generated Certificate

            X509v3 Subject Key Identifier: 

                92:A4:5B:5C:88:0D:CE:84:67:5F:2A:9B:1F:57:15:AD:12:A9:13:CE

            X509v3 Authority Key Identifier: 

                keyid:B6:C0:56:B6:E7:CF:C6:9B:CB:35:6D:1F:C9:06:94:69:D2:D9:23:68



Certificate is to be certified until Apr 27 12:51:29 2019 GMT (365 days)

Sign the certificate? [y/n]:y





1 out of 1 certificate requests certified, commit? [y/n]y

Write out database with 1 new entries

Data Base Updated



4）在CA上将CA签发的证书传送到httpd服务器：

[root@chenliang ssl]# scp /etc/pki/CA/certs/httpd.crt  /etc/httpd/ssl/          

5）在httpd服务器上，删除证书请求文件：

[root@chenliang ssl]# ls
httpd.crt  httpd.csr  httpd.key
[root@chenliang ssl]# rm -fr httpd.csr
[root@chenliang ssl]# ls
httpd.crt  httpd.key

6)在httpd服务器上配置ssl支持：(需要安装httpd中的mod_ssl模块，没有安装需要提前安装)

配置https的虚拟主机：

[root@chenliang ~]# vim /etc/httpd/conf.d/ssl.conf

<VirtualHost>
     DocumentRoot "/data/vhosts/www2"
     ServerName www2.cl7.com:443
     SSLCertificateFile /etc/httpd/ssl/httpd.crt 
     SSLCertificateKeyFile /etc/httpd/ssl/httpd.key

</VirtualHost>

5.测试https是否配置成功：

1.png





至此，httpd-2.4基于主机名建立虚拟主机并实现web站点的https服务完成



评论个数  1倒序时间正序时间