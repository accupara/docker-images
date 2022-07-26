# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        clang \
        liblz4-dev \
        libssh-dev \
        libxxhash-dev \
        libzstd-dev \
        perl \
        python3-pip \
 && sudo pip3 install commonmark
