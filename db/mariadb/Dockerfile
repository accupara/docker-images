# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9

COPY galera.list /etc/apt/sources.list.d/galera.list

RUN set -x \
 && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 8DA84635 \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y software-properties-common \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    bison \
    chrpath \
    cracklib-runtime \
    debhelper \
    dh-apparmor \
    dh-exec \
    flex \
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
    libreadline-dev \
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
# Install Galera
 && sudo apt-get install -y \
    galera-4 \
    #mysql-wsrep-8.0 \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Cleanup apt cache
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

ENV WSREP_PROVIDER="/usr/lib/galera/libgalera_smm.so"
