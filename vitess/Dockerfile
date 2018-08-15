# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Accupara Inc. "contact@accupara.com"

RUN set -x \
 && sudo apt-get update && \
    sudo apt-get install -y \
        golang \
        govendor \
        git \
        mariadb-client \
        mariadb-server \
        python-pip \
        virtualenv \
        zlib1g-dev \
 && sudo pip install --upgrade pip \
 && mkdir -p /tmp/src/vitess.io \
 && cd /tmp/src/vitess.io \
 && git clone https://github.com/vitessio/vitess.git vitess \
 && cd /tmp/src/vitess.io/vitess \
 && ./bootstrap.sh
