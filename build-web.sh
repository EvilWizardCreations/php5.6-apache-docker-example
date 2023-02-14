#!/bin/bash
# USAGE:
# build-web.sh
#
# NOTE:
# Rebuild the Web Docker image composition.

docker-compose build --no-cache php-5-6-web-server \
&& docker-compose up -d