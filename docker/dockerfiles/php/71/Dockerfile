FROM php:7.1-fpm

ARG user=symfony
ARG node_version=8.1.0
ARG nvm_version=0.20.0

# Create user with home to work with permissions on files
RUN adduser --gecos "" --disabled-password $user

RUN apt-get clean && apt-get update

RUN apt-get install -y \
        nginx \
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
RUN pecl install apcu-5.1.7 xdebug && docker-php-ext-enable apcu xdebug

# Install Blackfire
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

RUN rm /etc/nginx/sites-enabled/default

# Config file and bin
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY conf/www.conf.default /usr/local/etc/php-fpm.d/www.conf.default
COPY bin/composer /usr/local/bin/composer

RUN chown $user:$user /usr/local/bin/composer && chmod 775 /usr/local/bin/composer

RUN echo "$user:$user" | chpasswd
RUN echo "root:root" | chpasswd
RUN usermod -a -G sudo $user

USER $user

# Install nvm for $user
ENV NVM_DIR /home/$user/.nvm
ENV NODE_VERSION $node_version
RUN curl https://raw.githubusercontent.com/creationix/nvm/v$nvm_version/install.sh | bash

RUN /bin/bash -c "source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default"

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN echo "alias sf='php bin/console'\n"  >> /home/$user/.bashrc

WORKDIR /usr/share/nginx/html
