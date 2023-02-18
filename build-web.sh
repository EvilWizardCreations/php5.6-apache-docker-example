#!/bin/bash
# USAGE:
# build-web.sh
#
# NOTE:
# Rebuild the Web Docker image composition.

echo -e "Rebuilding EWC Web Docker Image"

# source the environment variables
set -o allexport; source .env; set +o allexport

docker-compose build --no-cache php-5-6-web-server \
&& docker-compose up -d
echo -e "http://localhost:$APP_PORT/"
