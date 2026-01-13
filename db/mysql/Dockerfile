# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 8DA84635 \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y software-properties-common \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    bison \
    chrpath \
    cmake \
    cracklib-runtime \
    debhelper \
    dh-apparmor \
    dh-exec \
    gdb \
    gnutls-dev \
    icu-devtools \
    libaio-dev \
    libarchive-dev \
    libcrack2-dev \
    libjemalloc-dev \
    libjudy-dev \
    libkrb5-dev \
    libncurses5-dev \
    libpam0g-dev \
    libpcre2-dev \
    libprotobuf-dev \
    libreadline-dev \
    libssl-dev \
    libsystemd-dev \
    libxml2-dev \
    lsb-release \
    ninja-build \
    pkg-config \
    perl \
    po-debconf \
    psmisc \
    unixodbc-dev \
    zlib1g-dev \
# Install Galera
 && sudo apt-get install -y \
    galera-4 \
    #mysql-wsrep-8.0 \
# Manually download boost and save it
 && cd /tmp \
 && export BOOST=1_77_0 \
# Sometimes Boost's servers run out of bandwidth
# && wget https://dl.bintray.com/boostorg/release/$(echo ${BOOST} | sed 's/_/./g')/source/boost_${BOOST}.tar.gz \
 && wget -q https://downloads.sourceforge.net/project/boost/boost/$(echo ${BOOST} | sed 's/_/./g')/boost_${BOOST}.tar.bz2 \
 && tar -xf boost_${BOOST}.tar.bz2 \
 && sudo mv boost_${BOOST} /opt/ \
 && sudo chown -R admin:admin /opt/boost_${BOOST} \
 && rm -f boost_${BOOST}.tar.bz2 \
# Cleanup apt cache
 && sudo eatmydata apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

ENV BOOST=1_77_0
