# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
MAINTAINER Crave.io Inc. "contact@crave.io"

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
