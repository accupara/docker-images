# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

ENV CMAKE_VER=3.23.2

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository ppa:maria-captains/travis-ci-helper-repo \
 && sudo apt-get update \
 && sudo apt-get install -y \
    bison \
    chrpath \
    cracklib-runtime \
    debhelper \
    dh-apparmor \
    dh-exec \
    dh-systemd \
    flex \
    galera-4 \
    gawk \
    gdb \
    gnutls-dev \
    iproute2 \
    libaio-dev \
    libarchive-dev \
    libboost-dev \
    libcrack2-dev \
    libcurl4-openssl-dev \
    libdbi-perl \
    libedit-dev \
    libjemalloc-dev \
    libjudy-dev \
    libkrb5-dev \
    liblz4-dev \
    libncurses5-dev \
    libnuma-dev \
    libpam0g-dev \
    libpcre2-dev \
    libreadline-gplv2-dev \
    libsnappy-dev \
    libssl-dev \
    libsystemd-dev \
    libxml2-dev \
    libzstd-dev \
    lsb-base \
    lsb-release \
    lsof \
    ninja-build \
    passwd \
    perl \
    po-debconf \
    procps \
    psmisc \
    rsync \
    socat \
    unixodbc-dev \
    uuid-dev \
    zlib1g-dev \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Cleanup apt cache
 && sudo apt-get clean

ENV WSREP_PROVIDER="/usr/lib/galera/libgalera_smm.so"
