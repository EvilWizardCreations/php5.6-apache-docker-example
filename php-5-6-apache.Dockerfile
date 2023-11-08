FROM php:5.6-apache as build-php-56-apache

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6"

ARG NPM_VERSION=6.4.1
ENV NPM_VERSION=$NPM_VERSION

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.7.1 /usr/bin/composer /usr/bin/composer

# The apt-get sources for this are so old it has been archived & needs changing
COPY ./build-assets/etc/apt/sources.list /etc/apt/sources.list

# The pecl is so old it needs the local offline install now
COPY ./build-assets/pecl/yaml-1.3.0.tgz /tmp/yaml-1.3.0.tgz

# Download the nodejs setup & set that it's a docker env.
ENV NODE_ENV docker
# Node -v v8.12.0
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash

# Enable some apache modules.
RUN a2enmod rewrite; \
    a2enmod headers; \
    a2enmod ssl

# Install some extra stuff
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \ 
      libxml2-dev \
      libzip-dev \
      libyaml-dev \
      zip \
      unzip \
      git \
      nodejs  \
      default-mysql-client \ 
      vim; \
    apt-get clean; \
    npm i npm@$NPM_VERSION -g

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl channel-update pecl.php.net && \
    pecl install --offline /tmp/yaml-1.3.0.tgz && \
    docker-php-ext-enable yaml && \
    rm /tmp/yaml-1.3.0.tgz

# A test build to play with while getting it all working
FROM php:5.6-apache as build-php-56-apache-test

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="5.6"

ARG NPM_VERSION=6.4.1
ENV NPM_VERSION=$NPM_VERSION

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.7.1 /usr/bin/composer /usr/bin/composer

# The apt-get sources for this are so old it has been archived & needs changing
COPY ./build-assets/etc/apt/sources.list /etc/apt/sources.list

# The pecl is so old it needs the local offline install now
COPY ./build-assets/pecl/yaml-1.3.0.tgz /tmp/yaml-1.3.0.tgz

# Download the nodejs setup & set that it's a docker env.
ENV NODE_ENV docker
# Node -v v8.12.0
#RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash

# Enable some apache modules.
RUN a2enmod rewrite; \
    a2enmod headers; \
    a2enmod ssl

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \ 
      libxml2-dev \
      libzip-dev \
      libyaml-dev \
      zip \
      unzip \
      git \
      nodejs  \
      default-mysql-client \ 
      vim; \
    apt-get clean

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl channel-update pecl.php.net && \
    pecl install --offline /tmp/yaml-1.3.0.tgz && \
    docker-php-ext-enable yaml
