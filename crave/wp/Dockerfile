# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && wget -q https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy \
 && chmod +x cloud_sql_proxy \
 && sudo chown admin:admin /opt \
 && mv cloud_sql_proxy /opt \
 && cd /opt \
 && wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-256.0.0-linux-x86_64.tar.gz \
 && tar -xf google-cloud-sdk-256.0.0-linux-x86_64.tar.gz \
 && ./google-cloud-sdk/install.sh -q --command-completion true --path-update true \
 && /opt/google-cloud-sdk/bin/gcloud components install beta cloud_sql_proxy --quiet \
 && sudo apt-get update \
 && sudo apt-get install -y \
        ca-certificates \
        composer \
        curl \
        libjpeg-dev \
        libmagickwand-dev \
        libpng-dev \
        libzip-dev \
        mysql-client \
        php \
        php-curl \
        php-zip \
        python \
        xz-utils \
 && mkdir /tmp/src && cd /tmp/src \
 && composer require google/cloud-tools \
 && composer require wp-cli/wp-cli-bundle \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
