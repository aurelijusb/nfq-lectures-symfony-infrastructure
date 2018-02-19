FROM php:7.2.2

MAINTAINER Aurelijus Banelis <aurelijus@banelis.lt>

WORKDIR /php

# Get composer: https://getcomposer.org/download/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN ln -s /php/composer.phar /usr/bin/composer

# Install dependencies
RUN apt-get update \
 && apt-get install -y git zip unzip \
 && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN apt-get update \
 && apt-get install -y libzip-dev \
 && docker-php-ext-install -j$(nproc) zip \
 && rm -rf /var/lib/apt/lists/*

# Not root user
RUN useradd -c 'PHP user' -m -d /home/php -s /bin/bash php
USER php
ENV HOME /home/php

WORKDIR /code
VOLUME /code

# For testing php framework
EXPOSE 8000
CMD '/bin/bash'