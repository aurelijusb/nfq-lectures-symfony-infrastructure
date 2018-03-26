FROM php:7.2.2-fpm

MAINTAINER Aurelijus Banelis <aurelijus@banelis.lt>

WORKDIR /php

# Install PHP extensions
RUN apt-get update \
 && apt-get install -y libzip-dev bash-completion \
 && docker-php-ext-install -j$(nproc) zip mysqli pdo_mysql \
 && rm -rf /var/lib/apt/lists/*

# Not root user
RUN useradd -c 'PHP user' -m -d /home/php -s /bin/bash php
USER php
ENV HOME /home/php

WORKDIR /code
VOLUME /code

