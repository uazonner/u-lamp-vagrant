# Vagrant Lamp Dev 

Простой Vagrant LAMP сервер с PHP7.

## Что внутри?

- ubuntu/trusty64
- Git, Vim, Curl, Nano и др.
- Apache2
- PHP7 с некоторыми дополнениями
- MySQL 5.6
- Node.js c NPM
- RabbitMQ
- Redis
- Composer
- phpMyAdmin

## Как использовать

- Клонировать этот репозиторий в свой проект
- Выполнить 'vagrant up'
- Изменить файл hosts (/etc/hosts), добавив:
````
192.168.100.100 app.dev
192.168.100.100 phpmyadmin.dev
````
- Открыть в браузере 'http://app.dev/' или 'http://phpmyadmin.dev/' (Пользователь и пароль - 'root')


