# Development stack with Docker, [PHP 7.1 FPM, MySQL 5.7, PhpMyAdmin, nginx 1.13]

This is a simple stack for development based on docker for multi sites

## How to use

Add your nginx configuration file in sites directory, execute the `domain.sh` to update your /etc/hosts :boom: then run `docker-compose up -d` enter to the php container and execute `sudo service nginx start`.

Type the server_name you've setup in your nginx configuration, if your nginx configuration is good the website must be up.

## Reminder

- The nginx container has static ip 172.45.0.10

### Package, tools, ...

- php fpm 7.1
- nginx 1.13
- mysql 5.7
- maildev
- phpmyadmin
- composer

### Port

- 8080:80 nginx
- 1080:80 maildev front web
- 1025:25 maildev smtp
- 8888:80 phpmyadmin
