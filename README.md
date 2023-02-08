# PHP 5.6 & Apache Dockerfile Example

A base PHP 5.6 Apache 2 image[^docker_pull_cmd_note] for demonstrating legacy projects available at [EWC Docker Hub](https://hub.docker.com/r/ewc2020/web).

An older version of ***PHP*** that some older codebase sites would require as an environment to run in.

Other Packages Included:

- Node
- Composer
- libxml2-dev
- libzip-dev
- libyaml-dev
- zip
- git
- nodejs
- default-mysql-client
- vim
- npm i npm@latest -g
- yaml-1.3.0

PHP Extensions:

- gettext 
- mysqli 
- pdo_mysql 
- zip
- yaml

[^docker_pull_cmd_note]: Use `docker pull ewc2020/web:php-5.6-apache` to get a copy of the image.
