#!/bin/bash

# Check if OS is Debian/Ubuntu
if [ -f /etc/debian_version ]; then

echo "install gytpol for Ubuntu systems"
wget http://192.168.64.114/moran/gytpol/gytpol-client_2.7.0.23-23_amd64.deb
dpkg -i gytpol-client_2.7.0.23-23_amd64.deb

echo "Gytpol for Ubuntu successfully installed"
fi

# Check if OS is CentOS/Redhat
if [ -f /etc/redhat-release ]; then

echo "install gytpol for Redhat systems"
wget http://192.168.64.114/moran/gytpol/gytpol-client-2.7.0.23-23.x86_64.rpm
rpm -ivh gytpol-client-2.7.0.23-23.x86_64.rpm
echo "Gytpol for Redhat successfully installed"
fi
