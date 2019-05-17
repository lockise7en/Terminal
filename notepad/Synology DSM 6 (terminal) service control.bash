Webuserinterface, Synology recommended:

Control Panel, Task Scheduler, Create Scheduled Task, Stop/Start Service 

Terminal command:

ssh admin@server

sudo -i

synoservicecfg --list

synoservicecfg --hard-stop <service>

synoservicecfg -stop <service>

synoservicecfg --hard-start <service>

synoservicecfg -start <service>

synoservice –status

synoservice –restart <service>

synoservicectl –restart <service>

Apache webserver:

stop pkg-apache22

start pkg-apache22

reload pkg-apache22

restart DSM Webapplication:

restart synoscgi

