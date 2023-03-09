#!/bin/bash
# USAGE:
# push-build.sh
#
# NOTE:
# This wil tag the created image to the webserver repo & push the tagged imaged as latest.

echo -e "Publishing EWC Web Docker Image Build"

# source the environment variables
set -o allexport; source .env; set +o allexport

image=${BUILD_IMAGE:-php-5.6-apache}
image_tag=${BUILD_IMAGE_TAG:-v0.0.4}

# Tag the local copy to the remote webserver repo & push the release version
echo -e "Tagging build image as :$image_tag to webserver repo"
docker tag $image:$image_tag ewc2020/web:$image-$image_tag
echo -e "Pushing :$image-$image_tag to webserver repo"
docker push ewc2020/web:$image-$image_tag

# Tag the local webserver to :image & push the image tag version
echo -e "Tagging webserver image :$image-$image_tag to :$image-latest in webserver repo"
docker tag ewc2020/web:$image-$image_tag ewc2020/web:$image-latest
echo -e "Pushing :$image-latest to webserver repo"
docker push ewc2020/web:$image-latest
