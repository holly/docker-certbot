#!/usr/bin/env bash

set -e
set -u
set -o pipefail
set -C

APP=$(basename $PWD | sed -e 's/^docker\-//')
TAG="$USER/$APP"

#docker run --env-file ./.env -v certbot_data:/etc/letsencrypt --rm -it ${TAG}:latest
docker run --env-file ./.env --rm -it ${TAG}:latest
