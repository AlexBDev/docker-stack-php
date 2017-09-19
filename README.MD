# Development stack with Docker, [PHP 7.1 FPM, MySQL 5.7, PhpMyAdmin, nginx 1.13]

This is a simple stack for development based on docker for multi sites

## How to use

Add your nginx configuration file in sites directory, execute the `domain.sh` to update your /etc/hosts :boom: then run `docker-compose up -d` enter to the php container and execute `sudo service nginx start`.

Type the server_name you've setup in your nginx configuration, if your nginx configuration is good the website must be up.

## In depth

Two important directories is shared from the host to the php container `./app:/usr/share/nginx/html` and `./sites/:/etc/nginx/sites-enabled/`.
You need to put your code under the `app` directory like that `app/my_dir_to_code`.
Add the nginx configuration to `sites` directory, this directory is shared to avoid a copy from the build of the image or copy the files into container from command (annoying).

    root /usr/share/nginx/html/example.mysite/; (example.mysite is your dir code under app host directory app/example.mysite)
    server_name example.mysite; (Add your domain name and in your /etc/hosts or equivalent on your host with the ip php container 172.20.0.10 or use the domain.sh script)

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
