# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/golang:1.12-stretch
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        ant \
        golang \
        govendor \
        git \
        mariadb-client \
        mariadb-server \
        python-pip \
        virtualenv \
        zlib1g-dev \
 && sudo pip install --upgrade pip \
 && mkdir -p /go/src/vitess.io \
 && cd /go/src/vitess.io \
 && git clone https://github.com/vitessio/vitess.git vitess \
 && cd /go/src/vitess.io/vitess \
 && ./bootstrap.sh \
 && sudo mkdir -p /opt/vendor_internal ; sudo chown admin:admin /opt/vendor_internal \
 && cd vendor ; mv cloud.google.com github.com golang.org google.golang.org gopkg.in /opt/vendor_internal/

 COPY entrypoint.sh /tmp/
 ENTRYPOINT ["/tmp/entrypoint.sh"]

 # To use this container:
 # 1. Mount the vitess sources into /go/src/vitess.io/vitess inside the container:
 #    docker run --rm -it \
 #        -v `pwd`:/go/src/vitess.io/vitess \
 #        -w /go/src/vitess.io/vitess \
 #        accupara/vitess \
 #        bash
 # 2. Inside the container:
 #    1. Create the following symbolic links
 #        ln -s /opt/vendor_internal/cloud.google.com  /go/src/vitess.io/vitess/vendor/cloud.google.com
 #        ln -s /opt/vendor_internal/github.com        /go/src/vitess.io/vitess/vendor/github.com
 #        ln -s /opt/vendor_internal/golang.org        /go/src/vitess.io/vitess/vendor/golang.org
 #        ln -s /opt/vendor_internal/google.golang.org /go/src/vitess.io/vitess/vendor/google.golang.org
 #        ln -s /opt/vendor_internal/gopkg.in          /go/src/vitess.io/vitess/vendor/gopkg.in
 #    2. cd /go/src/vitess.io/vitess ; source dev.env
 #    3. make build
