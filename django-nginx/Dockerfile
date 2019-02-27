# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get -y install \
        libpq-dev \
        multitail \
        nginx \
        python3-dev \
        python3-pip \
        python3-software-properties \
        sqlite3 \
        sshpass \
        supervisor \
 && sudo pip3 install --upgrade \
        pip==18.1 \
        setuptools \
 && sudo pip3 install --upgrade \
        django \
        uwsgi

RUN sudo rm /etc/nginx/sites-enabled/*

# nginx conf file
COPY nginx.conf /etc/nginx/
COPY nginx-site.conf /etc/nginx/sites-enabled/

# Use supervisord to start django and nginx by default
COPY apps.conf /etc/supervisor/conf.d/
COPY supervisord.conf /etc/supervisor/
CMD ["sudo", "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
