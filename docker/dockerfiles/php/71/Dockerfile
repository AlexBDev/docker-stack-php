FROM php:7.1-fpm

ARG user=symfony

# Create user with home to work with permissions on files
RUN adduser --gecos "" --disabled-password $user

RUN apt-get clean && apt-get update

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libssl-dev \
        nano \
        sudo \
        libfontconfig1 \
        libxrender1 \
        git \
        python

RUN docker-php-ext-install -j$(nproc) \
        exif \
        iconv \
        opcache \
        bcmath \
        ctype \
        dom \
        fileinfo \
        gd \
        gettext \
        intl \
        json \
        mcrypt \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        phar \
        simplexml \
        zip

RUN pecl channel-update pecl
RUN pecl install apcu-5.1.7 && docker-php-ext-enable apcu


# Config file and bin
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY conf/www.conf.default /usr/local/etc/php-fpm.d/www.conf.default
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer

RUN chown $user:$user /usr/local/bin/composer && chmod 775 /usr/local/bin/composer

# Set password and add sudo group to new user
RUN echo "$user:$user" | chpasswd
RUN echo "root:root" | chpasswd
RUN usermod -a -G sudo $user

RUN echo "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

USER $user

RUN echo "alias sf='php bin/console'\n"  >> /home/$user/.bashrc

WORKDIR /usr/share/nginx/html
