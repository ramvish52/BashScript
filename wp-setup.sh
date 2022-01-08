#!/bin/bash

#################### Intall php 7.4 on centos 7 ##########################################

## Step 1: Add EPEL and REMI Repository
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm

## Step 2: Install PHP 7.4 on CentOS 7
sudo yum -y install yum-utils
sudo yum-config-manager --enable remi-php74

## Now update and install php74
sudo yum update -y
sudo yum install php php-cli -y

## install additional packages:
sudo yum install -y php  php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json

#################### Intall HTTPD ##########################################
sudo yum install httpd -y

## Download wordpress latest version
cd /var/www/html
sudo yum install wget
sudo wget https://wordpress.org/latest.tar.gz /var/www/html
sudo tar -xvzf latest.tar.gz
mv wordpress/* .
sudo chmod -R 777 /var/www/html
systemctl start httpd
systemctl enable httpd
