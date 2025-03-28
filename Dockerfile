FROM alpine

RUN apk update && \
    apk add --no-cache busybox-suid && \
    apk add --no-cache --virtual .build-deps build-base git && \
    git clone https://github.com/brandt/symlinks.git /tmp/symlinks && \
    cd /tmp/symlinks && \
    make && \
    make INSTALL=install MANDIR=/usr/share/man install && \
    apk del .build-deps && \
    rm -rf /root/.cache /tmp/* /var/cache/apk/* /var/tmp/*

RUN rm -rf /var/spool/cron/crontabs && \
    mkdir -p /var/spool/cron/crontabs && \
    cat <<EOF > /var/spool/cron/crontabs/root
0 0 * * * /usr/bin/symlinks -cdors /host >> /var/log/cron/cron.log 2>&1
EOF

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["crond", "-f"]
