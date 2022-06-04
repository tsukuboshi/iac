#!/bin/bash

# ====================
#
# Automatic Apache/MySQL Installer
#
# ====================

#インストール手順は以下URLを参照
#https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html

#ソフトウェアパッケージ最新バージョン取得
yum update -y

#Apache導入
yum install -y httpd

#MySQL(クライアント)導入
yum install -y mysql

#Redis(クライアント)導入
amazon-linux-extras install epel -y
yum install gcc jemalloc-devel openssl-devel tcl tcl-devel -y
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make

#Apache起動
systemctl start httpd

#Apache自動起動設定
systemctl enable httpd

#Session Manager用ユーザ事前作成
useradd -m -U ssm-user
echo "ssm-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users

#ファイル書き込み権限割り当て
usermod -a -G apache ssm-user
chown -R ssm-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

#Apache用indexファイル書き換え
echo $(hostname) > /var/www/html/index.html
