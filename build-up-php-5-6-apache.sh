#!/bin/bash
# USAGE:
# build-up-php-5-6-apache.sh
#
# NOTE:
# Rebuild the Docker image & compose up.

# source the environment variables
set -o allexport; source "${PWD}/.env"; set +o allexport

# Use the EWC Protocol to build the image of the service & compose up
ewc-docker-build-up.sh "php-5-6-apache" "${APACHE_PHP56_DOCKER_BUILD_DESC:-PHP ${PHP_VERSION} & Apache Web Server}"
