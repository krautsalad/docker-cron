FROM alpine

RUN apk update && \
    apk add --no-cache busybox-suid curl tzdata && \
    rm -rf /root/.cache /tmp/* /var/cache/apk/* /var/tmp/*

RUN rm -rf /var/spool/cron/crontabs && \
    mkdir -p /var/spool/cron/crontabs && \
    touch /var/spool/cron/crontabs/root

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["crond", "-f"]
