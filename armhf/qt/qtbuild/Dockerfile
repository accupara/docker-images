# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/armhf_ubuntu:16.04
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

RUN sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    sudo apt-get update
RUN sudo apt-get -y install \
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
        ruby && \
    sudo apt-get build-dep -y qt5-default
