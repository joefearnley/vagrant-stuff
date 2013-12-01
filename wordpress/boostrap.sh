#!/bin/bash

sudo apt-get update

# Install MySQL without prompt, set root password to "password"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'

sudo apt-get install -y vim curl wget build-essential python-software-properties

sudo add-apt-repository -y ppa:ondrej/php5

sudo apt-get update 

sudo apt-get install -y git-core php5 apache2 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-mcrypt php5-xdebug mysql-server-5.5

sudo chown vagrant /etc/apache2/apache2.conf
echo 'ServerName localhost' >>  /etc/apache2/apache2.conf

sudo service apache2 restart

sudo a2enmod rewrite

# 
# 
rm -rf /var/www
ln -sf /vagrant/www /var/www

sudo service apache2 restart

#
# To avoid the interactive mysql prompt, the passsword is already set, but 
# root does not have some of the privileges to create a user and database.
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
mysql -u root -ppassword -e "FLUSH PRIVILEGES;"

#
# Create database and user for Wordpress.
mysql -u root -ppassword -e "CREATE DATABASE wordpress1;"
mysql -u root -ppassword -e "CREATE USER 'wp1'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON wordpress1.* TO 'wp1'@'localhost';"
mysql -u root -ppassword -e "FLUSH PRIVILEGES;"

