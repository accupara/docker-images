# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

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
    perl \
    po-debconf \
    psmisc \
    unixodbc-dev \
    zlib1g-dev \
# Manually download boost and save it
 && cd /tmp \
# Sometimes Boost's servers run out of bandwidth
# && wget https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.gz \
 && wget https://downloads.sourceforge.net/project/boost/boost/1.70.0/boost_1_70_0.tar.bz2 \
 && tar -xf boost_1_70_0.tar.bz2 \
 && sudo mv boost_1_70_0 /opt/ \
 && sudo chown -R admin:admin /opt/boost_1_70_0 \
 && rm -rf boost_1_70_0.tar.bz2 \
# Cleanup apt cache
 && sudo apt-get clean
