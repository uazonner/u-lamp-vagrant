# Vagrant Lamp Dev 

Простой Vagrant LAMP сервер с PHP7.

## Что внутри?

- ubuntu/trusty32
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
192.168.1.150 dev.local
192.168.1.150 dev-db.local
````
- Открыть в браузере 'http://dev.local/' или 'http://dev-db.local/' (Пользователь и пароль - 'root')


