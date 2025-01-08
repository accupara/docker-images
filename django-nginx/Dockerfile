# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
        libpq-dev \
        multitail \
        nginx \
        python3-dev \
        python3-pip \
        python3-software-properties \
        sqlite3 \
        sshpass \
        supervisor \
 && sudo pip3 install --break-system-packages --upgrade \
        django \
        setuptools \
        uwsgi \
 && sudo rm /etc/nginx/sites-enabled/*

# nginx conf file
COPY nginx.conf /etc/nginx/
COPY nginx-site.conf /etc/nginx/sites-enabled/

# Use supervisord to start django and nginx by default
COPY apps.conf /etc/supervisor/conf.d/
COPY supervisord.conf /etc/supervisor/
CMD ["sudo", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
