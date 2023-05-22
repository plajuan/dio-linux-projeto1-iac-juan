#!/bin/bash

echo "Server update..."
apt-get update
apt-get upgrade -y
apt-get install apache2 -y
apt-get install unzip -y
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
unzip -o main.zip
cd linux-site-dio-main
cp -R * /var/www/html
echo "Server update finished"
