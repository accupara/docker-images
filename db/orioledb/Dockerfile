# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# Derive from postgress base container
FROM accupara/postgres:ubuntu_2004
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y dist-upgrade \
 && sudo apt-get install -y \
    libpq-dev \
# Download the prerequisites script from OrioleDB's Github and use it to configure the environment
 && wget -O /tmp/prerequisites.sh https://raw.githubusercontent.com/orioledb/orioledb/main/ci/prerequisites.sh \
 && chmod +x /tmp/prerequisites.sh \
 && export GITHUB_ENV=/tmp/ghenv \
 && export COMPILER=gcc \
 && export CHECK_TYPE=valgrind_1 \
 && /tmp/prerequisites.sh \
# Cleanup the image
 && sudo apt-get clean
