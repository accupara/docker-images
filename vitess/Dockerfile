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
 && ./bootstrap.sh \
 && sudo mkdir -p /opt/vendor_internal ; sudo chown admin:admin /opt/vendor_internal \
 && cd vendor ; mv cloud.google.com github.com golang.org google.golang.org gopkg.in /opt/vendor_internal/

 # To use this container:
 # 1. Mount the vitess sources into /tmp/src/vitess.io/vitess inside the container:
 #    docker run --rm -it \
 #        -v `pwd`:/tmp/src/vitess.io/vitess \
 #        -w /tmp/src/vitess.io/vitess \
 #        bash
 # 2. Inside the container:
 #    1. Create the following symbolic links
 #        ln -s /opt/vendor_internal/cloud.google.com  /tmp/src/vitess.io/vitess/vendor/cloud.google.com
 #        ln -s /opt/vendor_internal/github.com        /tmp/src/vitess.io/vitess/vendor/github.com
 #        ln -s /opt/vendor_internal/golang.org        /tmp/src/vitess.io/vitess/vendor/golang.org
 #        ln -s /opt/vendor_internal/google.golang.org /tmp/src/vitess.io/vitess/vendor/google.golang.org
 #        ln -s /opt/vendor_internal/gopkg.in          /tmp/src/vitess.io/vitess/vendor/gopkg.in
 #    2. cd /tmp/src/vitess.io/vitess ; source dev.env
 #    3. make build
