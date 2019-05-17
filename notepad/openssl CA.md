
原创 OpenSSl生成SSL证书(支持https)
MrBoring2018.05.24阅 114
“版权声明：原创作品，如需转载，请注明出处。否则将追究法律责任
一：环境与安装说明

     WIN7_64，Nginx服务器，OpenSSL_Win64。本人使用phpStudy集成开发环境，使用Nginx+PHP，支持浏览器https请求。

     nginx下载地址：http://nginx.org/en/download.html 
     openssl下载地址：http://slproweb.com/products/Win32OpenSSL.html 
     官网地址：https://www.openssl.org/source/



二：安装OpenSSL及配置

    1>下载后双击安装，默认安装路径是C:\OpenSSL-Win64

    2>配置环境变量，这里不细说，略过。

    

三：生成ssl证书

   1>首先，无论是在Linux下还是在Windows下的Cygwin中，进行下面的操作前都须确认已安装OpenSSL软件包。

   2>创建根证书密钥文件myopenssl.key，输入以下命令:  openssl genrsa -des3 -out myopenssl.key

       blob.png

      这里会提示让输入两次密码，请保持两次密码一致

      Enter pass phrase for root.key: ← 输入一个新密码 
      Verifying – Enter pass phrase for root.key: ← 重新输入一遍密码

   3>创建根证书的申请文件myopenssl.csr，输入以下命令: openssl req -new -key myopenssl.key -out myopenssl.csr

      blob.png

      以下是提示信息  

        Enter pass phrase for root.key: ← 输入前面创建的密码 
        You are about to be asked to enter information that will be incorporated 
        into your certificate request. 
        What you are about to enter is what is called a Distinguished Name or a DN. 
        There are quite a few fields but you can leave some blank 
        For some fields there will be a default value, 
        If you enter ‘.’, the field will be left blank. 
        —– 
        Country Name (2 letter code) [AU]:CN ← 国家代号，中国输入CN 
        State or Province Name (full name) [Some-State]:BeiJing ← 省的全名，拼音 
        Locality Name (eg, city) []:BeiJing ← 市的全名，拼音 
        Organization Name (eg, company) [Internet Widgits Pty Ltd]:MyCompany Corp. ← 公司英文名 
        Organizational Unit Name (eg, section) []: ← 可以不输入 
        Common Name (eg, YOUR name) []: ← 此时不输入 
        Email Address []:admin@mycompany.com ← 电子邮箱，可随意填

        Please enter the following ‘extra’ attributes 
        to be sent with your certificate request 
        A challenge password []: ← 可以不输入 
        An optional company name []: ← 可以不输入

    4>创建一个自当前日期起为期十年的根证书myopenssl.crt，输入以下命令:openssl x509 -req -days 3650 -sha1 -extensions v3_ca -signkey myopenssl.key -in myopenssl.csr -out myopenssl.crt

     blob.png

      以下是提示信息：

     Enter pass phrase for root.key: ← 输入前面创建的密码


     5>创建服务器证书密钥server.key，输入以下命令：openssl genrsa –des3 -out server.key 2048

     blob.png

     运行时会提示输入密码,此密码用于加密key文件(参数des3便是指加密算法,当然也可以选用其他你认为安全的算法.),以后每当需读取此文件(通过openssl提供的命令或API)都需输入口令.如果觉得不方便,也可以去除这个口令,但一定要采取      其他的保护措施。

     去除key文件口令的命令: 
      openssl rsa -in server.key -out server.key

     6>创建服务器证书的申请文件server.csr，输入以下命令：openssl req -new -key server.key -out server.csr

      blob.png

    Country Name (2 letter code) [AU]:CN ← 国家名称，中国输入CN 

    State or Province Name (full name) [Some-State]:BeiJing ← 省名，拼音 
    Locality Name (eg, city) []:BeiJing ← 市名，拼音 
    Organization Name (eg, company) [Internet Widgits Pty Ltd]:MyCompany Corp. ← 公司英文名 
    Organizational Unit Name (eg, section) []: ← 可以不输入 
    Common Name (eg, YOUR name) []:www.mycompany.com ← 服务器主机名，若填写不正确，浏览器会报告证书无效，但并不影响使用 
    Email Address []:admin@mycompany.com ← 电子邮箱，可随便填

    Please enter the following ‘extra’ attributes 
    to be sent with your certificate request 
    A challenge password []: ← 可以不输入 
    An optional company name []: ← 可以不输入

     7>创建自当前日期起有效期为期三年的服务器证书server.crt，输入以下命令：

     openssl x509 -req -days 1095 -sha1 -extensions v3_req -CA myopenssl.crt -CAkey myopenssl.key -CAserial myopenssl.srl -CAcreateserial -in server.csr -out server.crt

      blob.png

    8>创建客户端证书密钥文件client.key，输入以下命令：openssl genrsa -des3 -out client.key 2048

    blob.png

    Enter pass phrase for client.key: ← 输入一个新密码 
    Verifying – Enter pass phrase for client.key: ← 重新输入一遍密码

    9>创建客户端证书的申请文件client.csr，输入以下命令：openssl req -new -key client.key -out client.csr

     blob.png


    Country Name (2 letter code) [AU]:CN ← 国家名称，中国输入CN 
    State or Province Name (full name) [Some-State]:BeiJing ← 省名称，拼音 
    Locality Name (eg, city) []:BeiJing ← 市名称，拼音 
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:MyCompany Corp. ← 公司英文名 
   Organizational Unit Name (eg, section) []: ← 可以不填 
   Common Name (eg, YOUR name) []:Lenin ← 自己的英文名，可以随便填 
   Email Address []:admin@mycompany.com ← 电子邮箱，可以随便填

   Please enter the following ‘extra’ attributes 
   to be sent with your certificate request 
   A challenge password []: ← 可以不填 
   An optional company name []: ← 可以不填

   10>创建一个自当前日期起有效期为三年的客户端证书client.crt，输入以下命令：

   openssl x509 -req -days 1095 -sha1 -extensions v3_req -CA myopenssl.crt -CAkey myopenssl.key -CAserial myopenssl.srl -CAcreateserial -in client.csr -out client.crt

   blob.png

   11>将客户端证书文件client.crt和客户端证书密钥文件client.key合并成客户端证书安装包client.pfx，输入以下命令：openssl pkcs12 -export -in client.crt -inkey client.key -out client.pfx

    blob.png

   Enter pass phrase for client.key: ← 输入上面创建的密码 
   Enter Export Password: ← 输入一个新的密码，用作客户端证书的保护密码，在客户端安装证书时需要输入此密码 
   Verifying – Enter Export Password: ← 确认密码

    12>保存生成的文件备用，其中server.crt和server.key是配置单向SSL时需要使用的证书文件，client.crt是配置双向SSL时需要使用的证书文件，client.pfx是配置双向SSL时需要客户端安装的证书文件.crt文件和.key可以合到一个文件里 面，把2个文件合成了一个.pem文件（直接拷贝过去就行了）。







