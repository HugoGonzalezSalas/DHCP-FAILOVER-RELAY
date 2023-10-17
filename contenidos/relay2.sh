#!/bin/bash
apt update 
apt upgrade -y
apt install isc-dhcp-server -y
cat <<EOF >>/etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto enp0s3
iface enp0s3 inet dhcp

auto enp0s8
iface enp0s8 inet dhcp
EOF

cat <<EOF >>/etc/default/isc-dhcp-relay
SERVERS="192.168.1.2"
INTERFACES="enp0s8"
OPTIONS=""
EOF

cat <<EOF >>/etc/sysctl.conf
net.ipv4.ip_forward=1
EOF

ifdown enp0s3
ifdown enp0s8
ifup enp0s3
ifup enp0s8
systemctl restart networking.service
systemctl restart isc-dhcp-server.service
