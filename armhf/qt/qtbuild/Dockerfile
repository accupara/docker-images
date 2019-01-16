# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04_arm32v7
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && sudo apt-get update \
 && sudo apt-get -y install \
        bison \
        firebird-dev \
        flex \
        gcc-5 \
        git \
        gperf \
        libasound2-dev \
        libdouble-conversion-dev \
        libfontconfig1-dev \
        libglu1-mesa-dev \
        libgstreamer0.10-dev \
        libgstreamer-plugins-base0.10-dev \
        libharfbuzz-dev \
        libicu-dev \
        libinput-dev \
        libpcre++-dev \
        libphonon-dev \
        libproxy-dev \
        libsqlite3-dev \
        libssl-dev \
        libx11-xcb-dev \
        "^libxcb.*" \
        libxcursor-dev \
        libxcomposite-dev \
        libxdamage-dev \
        libxi-dev \
        libxslt-dev \
        libxrandr-dev \
        libxrender-dev \
        perl \
        python \
        subversion \
        ruby
