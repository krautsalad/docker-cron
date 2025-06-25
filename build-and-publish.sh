#!/bin/sh
set -ex

docker build --no-cache --progress=plain -t krautsalad/cron:latest -f docker/Dockerfile .
docker push krautsalad/cron:latest

VERSION=$(git describe --tags "$(git rev-list --tags --max-count=1)")

docker tag krautsalad/cron:latest krautsalad/cron:${VERSION}
docker push krautsalad/cron:${VERSION}
