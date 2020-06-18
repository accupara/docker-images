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
    libaio-dev \
    libarchive-dev \
    libboost-dev \
    libcrack2-dev \
    libjemalloc-dev \
    libjudy-dev \
    libkrb5-dev \
    libncurses5-dev \
    libpam0g-dev \
    libpcre2-dev \
    libpcre3-dev \
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
# Cleanup apt cache
 && sudo apt-get clean

ENV WSREP_PROVIDER="/usr/lib/galera/libgalera_smm.so test"