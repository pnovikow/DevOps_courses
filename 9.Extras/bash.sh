#!/bin/bash
sudo yum update -y

sudo yum install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
sudo yum-config-manager --disable remi-php54
sudo yum-config-manager --enable remi-php73
sudo yum install php php-mysqlnd
sudo systemctl restart httpd.service

wget http://repo.mysql.com/mysql57-community-release-el7.rpm
sudo -y rpm -ivh mysql57-community-release-el7.rpm
sudo -y yum update
sudo -y yum install mysql-server
sudo systemctl start mysqld

curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs
