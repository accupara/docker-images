# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y software-properties-common \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
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
        python3 \
        python3-html5lib \
# for webengine:
        libavcodec-dev \
        libavformat-dev \
        libavutil-dev \
        libevent-dev \
        libfontconfig1-dev \
        libjsoncpp-dev \
        libminizip-dev \
        libopus-dev \
        libprotobuf-dev \
        libre2-dev \
        libsnappy-dev \
        libsrtp0-dev \
        libssl-dev \
        libvpx-dev \
        libwebp-dev \
        libxcursor-dev \
        libxcomposite-dev \
        libxdamage-dev \
        libxrandr-dev \
        libxss-dev \
        protobuf-compiler \
# Install the newest cmake
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr
