# U Lamp Vagrant 

Simple Vagrant LAMP server.

## What is inside?

- ubuntu/trusty64
- Git, Vim, Curl, Nano и др.
- Apache2
- PHP 7.1
-- PHP loaded extensions: date, libxml, openssl, pcre, zlib, filter, hash, Reflection, SPL, session, standard, apache2handler, mysqlnd, PDO, xml, bcmath, calendar, ctype, curl, dom, mbstring, fileinfo, ftp, gd, gettext, iconv, igbinary, imagick, imap, intl, json, exif, mcrypt, msgpack, mysqli, pdo_mysql, Phar, posix, readline, shmop, SimpleXML, soap, sockets, ssh2, sysvmsg, sysvsem, sysvshm, tokenizer, uploadprogress, wddx, xmlreader, xmlwriter, xsl, zip, memcached, Zend OPcache, xdebug.
-- PHP config: memory_limit =	256M, post_max_size =	256M, upload_max_filesize = 256M, display_errors = On, error_reporting = E_ALL
- MariaDb
- Node.js and NPM
- Composer
- phpMyAdmin

## Dependencies

- Oracle VM VirtualBox
- Vagrant

## How to use

- Clone this repository in your project
- Run 'vagrant up' in terminal
- Edit hosts file (/etc/hosts), adding:

````
192.168.0.150 dev.local // local ip from router
192.168.0.150 phpmyadmin.dev.local // local ip from router
````

- Open in browser 'http://dev.local/' or 'http://phpmyadmin.dev.local/'
- By default mysql database pass and user - 'root'


