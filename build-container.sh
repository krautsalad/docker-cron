#!/bin/sh
set -ex
docker build --no-cache --progress=plain -t krautsalad/cron:latest -f Dockerfile .
