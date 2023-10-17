#!/bin/bash
apt update
apt upgrade
apt install isc-dhcp-serve
systemctl disable NetworkManager
systemctl stop NetworkManager

cat <<EOF >>/etc/dhcp/dhcpd.conf
# dhcpd.conf
#
# Sample configuration file for ISC dhcpd
#

# option definitions common to all suppor>
option domain-name "example.org";
option domain-name-servers ns1.example.or>

default-lease-time 600;
max-lease-time 7200;

# The ddns-updates-style parameter contro>
# attempt to do a DNS update when a lease>
# behavior of the version 2 packages ('no>
# have support for DDNS.)

ddns-update-style none;

failover peer "FAILOVER" {
 secondary;
 address 192.168.0.3;
 port 647;
 peer address 192.168.0.2;
 peer port 647;
 max-unacked-updates 10;
 max-response-delay 30;
 load balance max seconds 3;
}

subnet 192.168.0.0 netmask 255.255.255.0 {
 option routers 192.168.0.2;
 option domain-name-servers 8.8.8.8;
 option subnet-mask 255.255.255.0;
 option broadcast-address 192.168.0.255;
 pool {
  failover peer "FAILOVER";
  range 192.168.0.5 192.168.0.50;
  }
}
EOF

cat <<EOF >>/etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto enp0s3
iface enp0s3 inet static
address 172.26.0.241
netmask 255.255.0.0
gateway 172.26.0.1

auto enp0s8
iface enp0s8 inet static
address 192.168.0.3
netmask 255.255.255.0
EOF

cat <<EOF >>/etc/default/isc-dhcp-server
# Defaults for isc-dhcp-server (sourced by /etc/init.d/isc-dhcp-server)

# Path to dhcpd's config file (default: /etc/dhcp/dhcpd.conf).
#DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf

# Path to dhcpd's PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid

# Additional options to start dhcpd with.
#       Don't use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=""

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACESv4="enp0s8"
INTERFACESv6=""
EOF

ifdown enp0s3
ifdown enp0s8
ifup enp0s3
ifup enp0s8
systemctl restart networking.service
systemctl restart isc-dhcp-server.service

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
apt install iptables-persistent
systemctl restart isc-dhcp-server.service
