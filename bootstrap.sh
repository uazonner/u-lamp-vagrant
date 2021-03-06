#! /usr/bin/env bash
v#!/usr/bin/env bash

# Variables may be change for your project
DBHOST=localhost
DBNAME=dev
DBUSER=root
DBPASSWD=root
SERVERHOST=dev.local

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

echo "-- Install packages and php extensions --"
sudo apt-get install -y --force-yes apache2 mariadb-server git-core nodejs
sudo apt-get install -y --force-yes php7.1 php7.1-common libapache2-mod-php7.1 php7.1-cli php7.1-dev php7.1-curl php7.1-opcache php7.1-mysql php7.1-pdo php7.1-memcached php7.1-xdebug php7.1-ssh2 php7.1-imap php7.1-soap php7.1-gd php7.1-mcrypt php7.1-intl php7.1-xml php7.1-zip php7.1-mbstring php7.1-bcmath
sudo apt-get install -y --force-yes php-uploadprogress
sudo apt-get install -y --force-yes libmagickwand-dev imagemagick
sudo pecl install imagick
sudo apt-get install -y --force-yes php7.1-imagick
Update

echo "-- Configure PHP & Apache --"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/apache2/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.1/apache2/php.ini
sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.1/apache2/php.ini
sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.1/apache2/php.ini

sudo a2enmod rewrite

echo "-- Creating virtual hosts --"
sudo ln -fs /vagrant/public/ /var/www/app
cat << EOF | sudo tee -a /etc/apache2/sites-available/default.conf
<Directory "/var/www/">
    AllowOverride All
</Directory>

<VirtualHost *:80>
    DocumentRoot /var/www/app
    ServerName $SERVERHOST
    ServerAlias www.$SERVERHOST
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /var/www/phpmyadmin
    ServerName phpmyadmin.$SERVERHOST
    ServerAlias www.phpmyadmin.$SERVERHOST
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /var/www/app
</VirtualHost>
EOF

sudo a2dissite 000-default.conf
sudo a2ensite default.conf

echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
sudo a2enconf fqdn

echo "-- Restart Apache --"
sudo /etc/init.d/apache2 restart

echo "-- Install Composer --"
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo "-- Install phpMyAdmin --"
wget -k https://files.phpmyadmin.net/phpMyAdmin/4.8.0.1/phpMyAdmin-4.8.0.1-all-languages.tar.gz
sudo tar -xzvf phpMyAdmin-4.8.0.1-all-languages.tar.gz -C /var/www/
sudo rm phpMyAdmin-4.8.0.1-all-languages.tar.gz
sudo mv /var/www/phpMyAdmin-4.8.0.1-all-languages/ /var/www/phpmyadmin

echo "-- Config phpMyAdmin --"
sudo cp /var/www/app/phpmyadmin/config.inc.php /var/www/phpmyadmin/config.inc.php
sudo mkdir /var/www/phpmyadmin/tmp && chmod 777 /var/www/phpmyadmin/tmp
sudo rm -R /var/www/app/phpmyadmin

echo "-- Restart Apache --"
sudo /etc/init.d/apache2 restart

sudo sed -i "s%http://dev.local%http://$SERVERHOST/%g" /var/www/app/index.php

echo "-- Setup databases --"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'%' IDENTIFIED BY '$DBPASSWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -proot -e "CREATE DATABASE $DBNAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci";
echo "   ...done."
echo "Virtual machine installed and configured"
echo "All components success installed, edit your /etc/hosts and browse to http://$SERVERHOST"