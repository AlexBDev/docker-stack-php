# PHP stack under Docker

PHP stack multi sites under Docker 

## Stack

- PHP-FPM 7.1 (composer)
- NGINX 1.13
- MySQL 5.7
- Maildev
- PhpMyAdmin

## How to use

### Nginx

- Add your nginx configuration for different sites under sites directory, check the example example.site.conf
- Execute the `domain.sh` to update your /etc/hosts

### Docker

- To deal with permission between shared volumes with host and guest, you must run

```bash
$ source user-permission.sh
```

- Run docker-compose.yml

```bash
$ docker-compose up -d
```

- Open your browser to http://example.mysite (or another configured domain name)

### Port

- 8080:80 NGINX (172.45.0.10)
- 1080:80 Maildev front web
- 1025:25 Maildev smtp
- 8888:80 PhpMyAdmin
