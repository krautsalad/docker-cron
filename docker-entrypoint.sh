#!/bin/sh
set -e
mkdir -p /host /var/log/cron
ln -sf /proc/1/fd/1 /var/log/cron/cron.log
exec "$@"
