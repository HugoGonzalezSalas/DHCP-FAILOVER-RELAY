#!/bin/bash
apt update
apt upgrade

cat <<EOF >>/etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

#dhcp
auto enp0s3
iface enp0s3 inet dhcp
EOF

systemctl restart networking.service
