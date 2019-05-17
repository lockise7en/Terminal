#/bin/bash
# @author: anyesu

if [ $# != 1 ] ; then 
echo "USAGE: $0 [HOST_IP]" 
exit 1; 
fi 

#============================================#
#   下面为证书密钥及相关信息配置，注意修改   #
#============================================#
PASSWORD="8#QBD2$!EmED&QxK"
COUNTRY=CN
PROVINCE=Chongqing
CITY=Chongqing
ORGANIZATION=lockyse7en
GROUP=lockyse7en.com
NAME=lockyse7en
HOST=$1
SUBJ="/C=$COUNTRY/ST=$PROVINCE/L=$CITY/O=$ORGANIZATION/OU=$GROUP/CN=$HOST"

echo "0.0.0.0: $1"
ca-key.pem="lockyse7en.com.key"
ca.pem="fullchain.cer"
server-key.pem=  
# 1.生成根证书RSA私钥，PASSWORD作为私钥文件的密码
openssl genrsa -passout pass:$PASSWORD -aes256 -out ca-key.pem 4096

# 2.用根证书RSA私钥生成自签名的根证书
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem -subj $SUBJ
ca-key.pem  ca.pem 
#============================================#
#          用根证书签发server端证书          #
#============================================#

# 3.生成服务端私钥
openssl genrsa -out server-key.pem 4096

# 4.生成服务端证书请求文件
openssl req -new -sha256 -key server-key.pem -out server.csr -subj "/CN=$HOST"

# 5.使tls连接能通过ip地址方式，绑定IP
echo subjectAltName = IP:127.0.0.1,IP:$HOST > extfile.cnf

# 6.使用根证书签发服务端证书
openssl x509  -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf

ca-key.pem  ca.pem   server-key.pem 

#============================================#
#          用根证书签发client端证书          #
#============================================#

# 7.生成客户端私钥
openssl genrsa -out key.pem 4096

# 8.生成客户端证书请求文件
openssl req -subj '/CN=client' -new -key key.pem -out client.csr

# 9.客户端证书配置文件
echo extendedKeyUsage = clientAuth > extfile.cnf

# 10.使用根证书签发客户端证书
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf

#============================================#
#                    清理                    #
#============================================#
# 删除中间文件
rm -f client.csr server.csr ca.srl extfile.cnf

# 转移目录
mkdir client server
cp {ca,cert,key}.pem client
cp {ca,server-cert,server-key}.pem server
rm {cert,key,server-cert,server-key}.pem

# 设置私钥权限为只读
chmod -f 0400 ca-key.pem server/server-key.pem client/key.pem