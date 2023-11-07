#!/bin/bash
# USAGE:
# push-build.sh
#
# NOTE:
# This wil tag the created image to the docker repo & push the tagged imaged as latest.

# source the environment variables
set -o allexport; source "${PWD}/.env"; set +o allexport

ewc-docker-make-latest.sh "${DOCKER_BUILD_REPO}" "${APACHE_PHP56_DOCKER_BUILD_IMAGE}" "${APACHE_PHP56_DOCKER_BUILD_IMAGE_TAG}"
