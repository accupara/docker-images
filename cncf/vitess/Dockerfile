# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/golang:1.18-buster

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        ant \
        govendor \
        mariadb-client \
        mariadb-server \
        openjdk-11-jdk \
        python-pip \
        virtualenv \
        zlib1g-dev \
 && sudo pip install --upgrade pip \
 && mkdir -p /go/src/vitess.io \
 && cd /go/src/vitess.io \
 && git clone https://github.com/vitessio/vitess.git vitess \
 && cd /go/src/vitess.io/vitess \
# Silence the wget in the bootstrap
 && sed -i 's/wget\(.*\)http/wget -q\1http/g' bootstrap.sh \
# ... and then run it
 && ./bootstrap.sh \
# We're going overboard with this container: We're going to even download the deps
 && make build \
# Cleanup
 && cd .. ; rm -rf vitess ; mkdir vitess \
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

 # To use this container:
 # Mount the vitess sources into /go/src/vitess.io/vitess inside the container and start the compilation:
 #    docker run --rm -it \
 #        -v $(readlink -f .):/go/src/vitess.io/vitess \
 #        -w /go/src/vitess.io/vitess \
 #        accupara/vitess:latest \
 #        make all
 # .... or you know ...
 # crave run --clean
 # :)
