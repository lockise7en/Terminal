/etc/config/network
config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'
	option ula_prefix 'fdb0:449f:d7e9::/48'


config interface 'wan'
	option ifname 'eth0'
	option proto 'dhcp'
	
config interface 'wan6'
	option ifname 'eth0'
	option proto 'dhcpv6'


config interface 'wan1'
	option ifname 'eth1'
	option proto 'dhcp'

config interface 'wan2'
	option ifname 'eth2'
	option proto 'dhcp'

config interface 'wan3'
	option ifname 'eth3'
	option proto 'dhcp'	
	
config interface 'lan'
	option type 'bridge'
	option ifname 'eth0 eth1 eth2 eth3'
	option proto 'static'
	option ipaddr '192.168.1.1'
	option netmask '255.255.255.0'
	option ip6assign '60'

config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'
	option ula_prefix 'fdb0:449f:d7e9::/48'

config interface 'lan'
	option type 'bridge'
	option ifname 'eth4'
	option proto 'static'
	option ipaddr '192.168.1.1'
	option netmask '255.255.255.0'
	option ip6assign '60'

config interface 'ens33'
	option ifname 'eth0'
	option proto 'dhcp'
	option metric '10'
	
config interface 'ens34'
	option ifname 'eth1'
	option proto 'dhcp'
	option metric '20'
Acquire::http { Proxy "http://192.168.168.2.3142"; };