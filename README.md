# Vagrant Lamp Dev 

Simple Vagrant LAMP server.

## What is inside?

- ubuntu/trusty32
- Git, Vim, Curl, Nano и др.
- Apache2
- PHP7 with some extensions
- MariaDb
- Node.js and NPM
- Composer
- phpMyAdmin

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


