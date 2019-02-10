#!/bin/bash

echo "prepare mysql"
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-codename select stretch'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-distro select debian'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-url string http://repo.mysql.com/apt/'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-preview select '
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-product select Ok'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-5.7'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-tools select '
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/unsupported-platform select abort'
DEBIAN_FRONTEND=noninteractive dpkg -i /home/webshop/scripts/mysql-apt-config_0.8.12-1_all.deb
echo mysql-server mysql-community-server/root-pass password root | debconf-set-selections
echo mysql-server mysql-community-server/re-root-pass password root | debconf-set-selections

apt-get update
echo "install server"
DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
