# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    libcurl4-openssl-dev \
    liblzma-dev \
    lld \
    python3-pip \
# Python3 deps
 && mkdir deps \
 && cd deps \
 && wget https://raw.githubusercontent.com/mongodb/mongo/master/etc/pip/compile-requirements.txt \
 && awk '{print $2}' compile-requirements.txt | \
    while read line ; do \
        if [ ! -z "$line" ] ; then \
            mkdir -p $(dirname $line) ; \
            cd $(dirname $line) ; \
            wget https://raw.githubusercontent.com/mongodb/mongo/master/etc/pip/$line ; \
            cd - ; \
        fi ; \
    done \
 && sudo python3 -m pip install -r compile-requirements.txt \
 && cd .. \
 && rm -rf deps \
# Cleanup apt cache
 && sudo apt-get clean
