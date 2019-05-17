autoreport: false
autolaunch: false
proxyall: true
systemproxy: true
headless: true

#!/bin/bash

#! start sshd
/usr/sbin/sshd -D
sleep 5

#! start lantern
/usr/bin/lantern -addr 0.0.0.0:8787 -headless true -proxyall true -systemproxy true
sleep 5

#! ss
/usr/bin/proxychains ssserver -p 8388 -k docker -d start

# just keep this script running
while [[ true ]]; do
sleep 1