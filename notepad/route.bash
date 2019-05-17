Destination     Gateway         Genmask         Flags    Metric Ref    Use Type Iface
106.81.231.1    *               255.255.255.255 UH       0      0        0 WAN0 ppp0
10.54.0.1       *               255.255.255.255 UH       0      0        0 WAN1 ppp1
10.0.99.0       *               255.255.255.0   U        0      0        0 MAN0 vlan2
192.168.168.0   *               255.255.255.0   U        0      0        0 LAN  br0
10.0.8.0        *               255.255.255.0   U        0      0        0 MAN1 vlan3
default         106.81.231.1    0.0.0.0         UG       0      0        0 WAN0 ppp0
default         10.0.8.1        0.0.0.0         UG       1      0        0 MAN1 vlan3