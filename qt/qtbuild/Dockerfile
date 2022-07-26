# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo apt-get update \
 && sudo apt-get -y install \
        bison \
        clang \
        flex \
        gperf \
        libclang-dev \
        libgl-dev \
        libopengl-dev \
        ninja-build \
        nodejs \
        perl \
        python \
# Install the newest cmake
 && export CMAKE_VER=3.22.0 \
 && wget -q https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-${CMAKE_VER}-linux-x86_64.sh \
 && chmod +x cmake-${CMAKE_VER}-linux-x86_64.sh \
 && sudo ./cmake-3.22.0-linux-x86_64.sh --skip-license --prefix=/usr \
 && rm cmake-${CMAKE_VER}-linux-x86_64.sh
