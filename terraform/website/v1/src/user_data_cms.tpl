#!/bin/bash

# ====================
#
# Automatic WordPress Installer
#
# ====================

#インストール手順は以下URLを参照
#https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html
#https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/hosting-wordpress.html

#ソフトウェアパッケージ最新バージョン取得
yum update -y

#EFSマウントヘルパー導入
yum install -y amazon-efs-utils

#EFSマウント設定
echo "${EFS_ID}:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab

#Apache導入
yum install -y httpd

#PHP導入
amazon-linux-extras install php7.2

#MySQL(クライアント)導入
yum install -y mysql

#ファイルシステムマウント
mount -a

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

#.htaccessファイル有効化(WordPressパーマネントリンクの使用に必須)
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

#一方のEC2インスタンス(instance_1a)でのみRDS用クエリを実行
if [ "$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)" == ${AZ_1} ]; then

  #WordPress用DBユーザ作成
  mysql -h ${DB_HOST} -u ${DB_ROOT_NAME} -p${DB_ROOT_PASS} -e "CREATE USER '${DB_USER_NAME}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"

  #WordPress用データベース作成
  mysql -h ${DB_HOST} -u ${DB_ROOT_NAME} -p${DB_ROOT_PASS} -e "CREATE DATABASE ${DB_NAME};"

  #DBユーザへのデータベース管理権限付与
  mysql -h ${DB_HOST} -u ${DB_ROOT_NAME} -p${DB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'localhost';"

  #DB変更有効化
  mysql -h ${DB_HOST} -u ${DB_ROOT_NAME} -p${DB_ROOT_PASS} -e "FLUSH PRIVILEGES;"

fi


#作業ディレクトリ移動
cd /tmp

#WordPressインストールパッケージダウンロード
wget https://wordpress.org/latest.tar.gz

#WordPressインストールパッケージ解凍
tar -xzf latest.tar.gz

#WordPress構成ファイルサンプルコピー
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php

#WordPress構成ファイル書き換え
sed -i "s/database_name_here/${DB_NAME}/g" /tmp/wordpress/wp-config.php
sed -i "s/username_here/${DB_ROOT_NAME}/g" /tmp/wordpress/wp-config.php
sed -i "s/password_here/${DB_ROOT_PASS}/g" /tmp/wordpress/wp-config.php
sed -i "s/localhost/${DB_HOST}/g" /tmp/wordpress/wp-config.php

#WordPress構成ファイルコピー
mkdir /var/www/html/blog
cp -r /tmp/wordpress/* /var/www/html/blog/

#Apache再起動
systemctl restart httpd
