#! /usr/bin/env bash
v#!/usr/bin/env bash

# Variables
DBHOST=localhost
DBNAME=dev
DBUSER=root
DBPASSWD=root

Update () {
    echo "-- Update packages --"
    sudo apt-get update
    sudo apt-get upgrade
}
Update

echo "-- Prepare configuration for MARIA DB --"
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $DBPASSWD"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $DBPASSWD"

echo "-- Install tools and helpers --"
sudo apt-get install -y --force-yes python-software-properties vim htop curl git npm

echo "-- Install PPA's --"
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.eenet.ee/pub/mariadb/repo/10.3/ubuntu trusty main'

sudo add-apt-repository ppa:ondrej/apache2
sudo add-apt-repository ppa:ondrej/php
sudo apt-get install -y --force-yes python-software-properties
Update

echo "-- Install NodeJS --"
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

echo "-- Install packages --"
sudo apt-get install -y --force-yes apache2 mariadb-server git-core nodejs
sudo apt-get install -y --force-yes php7.0 php7.0-common libapache2-mod-php7.0 php7.0-cli php7.0-dev php7.0-opcache php7.0-mysql php7.0-pdo php7.0-memcached php7.0-xdebug php7.0-ssh2 php7.0-imap php7.0-soap php7.0-gd php7.0-mcrypt php7.0-intl php7.0-xml php7.0-zip php7.0-mbstring php7.0-bcmath
sudo apt-get install -y --force-yes libmagickwand-dev imagemagick
sudo pecl install imagick
sudo apt-get install -y --force-yes php7.0-imagick
Update

echo "-- Configure PHP & Apache --"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini
sudo a2enmod rewrite

echo "-- Creating virtual hosts --"
sudo ln -fs /vagrant/public/ /var/www/app
cat << EOF | sudo tee -a /etc/apache2/sites-available/default.conf
<Directory "/var/www/">
    AllowOverride All
</Directory>

<VirtualHost *:80>
    DocumentRoot /var/www/app
    ServerName dev.local
    ServerAlias www.dev.local
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /var/www/phpmyadmin
    ServerName phpmyadmin.dev.local
    ServerAlias www.phpmyadmin.dev.local
</VirtualHost>
EOF
sudo a2ensite default.conf

echo "-- Restart Apache --"
sudo /etc/init.d/apache2 restart

echo "-- Install Composer --"
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo "-- Install phpMyAdmin --"
wget -k https://files.phpmyadmin.net/phpMyAdmin/4.8.0/phpMyAdmin-4.8.0-all-languages.tar.gz
sudo tar -xzvf phpMyAdmin-4.8.0-all-languages.tar.gz -C /var/www/
sudo rm phpMyAdmin-4.8.0-all-languages.tar.gz
sudo mv /var/www/phpMyAdmin-4.8.0-all-languages/ /var/www/phpmyadmin

echo "-- Setup databases --"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'%' IDENTIFIED BY '$DBPASSWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -proot -e "CREATE DATABASE $DBNAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci";