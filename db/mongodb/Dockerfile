# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# According to https://github.com/mongodb/mongo/blob/master/docs/building.md:
# gcc (>= 11.3), libcurl4-openssl-dev, liblzma-dev, python-dev-is-python3, libssl-dev, python (3.9+), and python modules poetry==1.5.1
# Ubuntu 22.04 satisfies gcc (11.4.0) and python (3.10.12)

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9 \
    SRC_ROOT=/tmp/src/mongo

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    libcurl4-openssl-dev \
    liblzma-dev \
    libssl-dev \
    python3-pip \
    python-dev-is-python3 \
 && sudo python3 -m pip install 'poetry==1.5.1' \
# Prep the poetry deps: Clone the mongo sources at the root in which the venv is to be sync'd
 && mkdir -p ${SRC_ROOT} && cd ${SRC_ROOT} \
 && git clone https://github.com/mongodb/mongo.git . \
# Sync the potry deps
 && python3 -m poetry install --no-root --sync \
# Cleanup
 && cd /tmp \
 && rm -rf ${SRC_ROOT} \
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
