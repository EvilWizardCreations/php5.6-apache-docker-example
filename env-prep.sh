#!/bin/bash
# USAGE:
# env-prep.sh
#
# NOTE:
# This will copy the .env-example file to .env for use with the docker-compose.

echo -e "Initializing PHP 5.6 & Apache2 Webserver Build Environment"

if [ ! -f "$PWD/.env" ]; then
    # Copy the default .env-example file
    echo -e "No environment for build process"
    echo -e "Copying default environment for build process"
    cp -a "$PWD/.env-example" "$PWD/.env"
fi
