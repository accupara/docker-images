# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        clang-6.0 \
        cpio \
        flex \
        gcc-arm-linux-gnueabi \
        libelf-dev \
        libncurses5-dev \
        libssl-dev \
        openssl \
        perl \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*
