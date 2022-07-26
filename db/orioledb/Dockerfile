# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# Derive from postgress base container
FROM accupara/postgres:ubuntu_2004

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    clang \
    clang-tools \
    libpq-dev \
# Download the prerequisites script from OrioleDB's Github and use it to configure the environment
 && wget -O /tmp/prerequisites.sh https://raw.githubusercontent.com/orioledb/orioledb/main/ci/prerequisites.sh \
 && chmod +x /tmp/prerequisites.sh \
 && export GITHUB_ENV=/tmp/ghenv \
 && export COMPILER=gcc \
 && export CHECK_TYPE=valgrind_1 \
 && /tmp/prerequisites.sh \
# Cleanup the image
 && rm /tmp/prerequisites.sh \
 && sudo apt-get clean
