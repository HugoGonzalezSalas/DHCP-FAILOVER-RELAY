#!/bin/bash
apt update
apt upgrade
apt install isc-dhcp-serve
systemctl disable NetworkManager
systemctl stop NetworkManager

