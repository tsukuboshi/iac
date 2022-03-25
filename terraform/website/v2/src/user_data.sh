#!/bin/bash
yum update -y

#Apacheインストール
yum install -y httpd

#Apache権限設定
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

#Apache用indexファイル書き換え
echo $(hostname) > /var/www/html/index.html

#Apache起動
systemctl enable httpd
systemctl start httpd

#mysqlクライアントインストール
yum install mysql-community-client -y
