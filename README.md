# Vagrant Lamp Dev 

Simple Vagrant LAMP server.

## What is inside?

- ubuntu/trusty32
- Git, Vim, Curl, Nano и др.
- Apache2
- PHP7 with some extensions
- MySQL
- Node.js and NPM
- RabbitMQ
- Redis
- Composer
- phpMyAdmin

## How to use

- Clone this repository in your project
- Run 'vagrant up' in terminal
- Edit hosts file (/etc/hosts), adding:

````
192.168.1.150 dev.local // local ip from router
192.168.1.150 dev-db.local // local ip from router
````

- Open in browser 'http://dev.local/' or 'http://dev-db.local/'
- By default mysql database pass and user - 'root'


