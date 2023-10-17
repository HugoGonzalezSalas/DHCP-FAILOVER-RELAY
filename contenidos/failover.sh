#!/bin/bash
apt update
apt upgrade
apt install isc-dhcp-server
apt install iptables

cat <<EOF >>/etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto enp0s3
iface enp0s3 inet static
address 172.26.0.240
netmask 255.255.0.0
gateway 172.26.0.1

auto enp0s8
iface enp0s8 inet static
address 192.168.0.2
netmask 255.255.255.0
EOF
