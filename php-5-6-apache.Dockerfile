FROM php:5.6-apache

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6"

# Enable some apache modules.
RUN a2enmod rewrite; \
    a2enmod headers; \
    a2enmod ssl

# Download the nodejs setup & set that it's a docker env.
ENV NODE_ENV docker
RUN curl --silent --location https://deb.nodesource.com/setup_14.x | bash

# Install some extra stuff
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \ 
      libxml2-dev \
      libzip-dev \
      libyaml-dev \
      zip \
      git \
      nodejs  \
      default-mysql-client \ 
      vim; \
    apt-get clean; \
    npm i npm@latest -g

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl install yaml-1.3.0 && \
    docker-php-ext-enable yaml

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.9.3 /usr/bin/composer /usr/bin/composer