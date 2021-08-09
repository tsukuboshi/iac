# MySQLのDockerイメージをpull
FROM mysql:8.0

# MySQL用ポートを開放
EXPOSE 3306

# MySQL設定ファイルをイメージ内にコピー
ADD ./settings/my.cnf /etc/mysql/conf.d/my.cnf

# docker run時にデーモンを実行
CMD ["mysqld"]
