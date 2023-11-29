# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# According to https://github.com/mongodb/mongo/blob/master/docs/building.md:
# gcc (>= 11.3), libcurl4-openssl-dev, liblzma-dev, python-dev-is-python3, libssl-dev, python (3.9+), and python modules poetry==1.5.1
# Ubuntu 22.04 satisfies gcc (11.4.0) and python (3.10.12)

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    libcurl4-openssl-dev \
    liblzma-dev \
    libssl-dev \
    python3-pip \
    python-dev-is-python3 \
 && sudo python3 -m pip install 'poetry==1.5.1' \
# Cleanup apt cache
 && sudo apt-get clean
