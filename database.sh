#!/bin/bash
read -p "Enter Database Root Password : " DATABASE_PASS
read -p "Enter Wordpress DataBaseName : " WORDPRESS_DB
read -p "Enter Wordpress UserName : " WORDPRESS_USER
read -p "Enter Wordpress User Password : " WORDPRESS_PASS

# Mysql
yum install mariadb-server -y

# Database Password
DATABASE_PASS=admin123

#mysql_secure_installation
sed -i 's/^127.0.0.1/0.0.0.0/' /etc/my.cnf

# starting & enabling mariadb-server
systemctl start mariadb
systemctl enable mariadb

#restore the dump file for the application
mysqladmin -u root password "$DATABASE_PASS"
mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
mysql -u root -p"$DATABASE_PASS" -e "create database $WORDPRESS_DB"
mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on $WORDPRESS_DB.* TO '$WORDPRESS_USER'@'localhost' identified by '$WORDPRESS_PASS'"
mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on $WORDPRESS_DB.* TO '$WORDPRESS_USER'@'%' identified by '$WORDPRESS_PASS'"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

# Restart mariadb-server
systemctl restart mariadb
