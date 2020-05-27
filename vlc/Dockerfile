# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository -y ppa:beineri/opt-qt-5.13.2-bionic \
 && sudo apt-get update \
 && sudo apt-get install -y \
        autoconf \
        automake \
        autopoint \
        bison \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        dh-buildinfo \
        dos2unix \
        flex \
        gettext \
        git-core \
        lftp \
        liba52-0.7.4-dev \
        libasound2-dev \
        libavcodec-dev \
        libavformat-dev \
        libdirectfb-dev \
        liblircclient-dev \
        liblua5.2-dev \
        libmodplug-dev \
        libpostproc-dev \
        libswscale-dev \
        libxcb-composite0-dev \
        libxcb-shm0-dev \
        libxcb-xkb-dev \
        libtool \
        locales \
        lua5.2 \
        make \
        openjdk-8-jdk \
        openssh-server \
        p7zip-full \
        pkg-config \
        qt513-meta-minimal \
        qt513quickcontrols \
        qt513quickcontrols2 \
        qt513svg \
        snapd \
        subversion \
        wayland-protocols \
        wget \
        zip \
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/* \
 && sudo locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
