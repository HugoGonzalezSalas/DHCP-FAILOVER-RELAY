#!/bin/bash
apt update
apt upgrade
apt install isc-dhcp-server
apt install iptables
systemctl disable NetworkManager
systemctl stop NetworkManager
