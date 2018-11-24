FROM timescale/timescaledb:1.0.0-pg9.6

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
                coreutils \
                dpkg-dev dpkg \
                gcc \
                libc-dev \
                make \
                util-linux-dev \
    \
    && wget https://github.com/timescale/pg_prometheus/archive/0.2.tar.gz -O pg_prom.tar.gz \
    && tar -zxf pg_prom.tar.gz \
    && make -C "$(ls .|grep pg_prometheus|head -1)" install \
    && apk del .build-deps \
    && rm -rf pg_pro*
