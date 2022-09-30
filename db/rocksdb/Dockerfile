# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

ENV CMAKE_VER=3.23.2

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo apt-get update \
 && sudo apt-get install -y \
    libbz2-dev \
    libgflags-dev \
    liblz4-dev \
    libsnappy-dev \
    libzstd-dev \
    ninja-build \
    zlib1g-dev \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Cleanup apt cache
 && sudo apt-get clean
