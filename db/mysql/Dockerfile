# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository ppa:maria-captains/travis-ci-helper-repo \
 && sudo apt-get update \
 && sudo apt-get install -y \
    bison \
    chrpath \
    cmake \
    cracklib-runtime \
    debhelper \
    dh-apparmor \
    dh-exec \
    dh-systemd \
    galera-4 \
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
    libreadline-gplv2-dev \
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
 && sudo apt-get clean

ENV BOOST=1_77_0
