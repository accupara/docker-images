# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo apt-get update \
 && sudo apt-get install -y \
    cmake \
    libbz2-dev \
    libgflags-dev \
    liblz4-dev \
    libsnappy-dev \
    libzstd-dev \
    ninja-build \
    zlib1g-dev \
# Cleanup apt cache
 && sudo apt-get clean
