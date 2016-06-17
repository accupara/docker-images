# Copyright (c) 2016 Accupara Inc. All rights reserved
FROM accupara/ubuntu:15.10
MAINTAINER Yuvraaj Kelkar "uv@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install --no-install-recommends -y  \
    build-essential     \
    git                 \
    glib2.0-dev         \
    libaio-dev          \
    libbluetooth-dev    \
    libbrlapi-dev       \
    libbz2-dev          \
    libcap-dev          \
    libcap-ng-dev       \
    libcurl4-gnutls-dev \
    libibverbs-dev      \
    libiscsi-dev        \
    libfdt-dev          \
    libglib2.0-dev      \
    libgtk-3-dev        \
    libjpeg8-dev        \
    liblzo2-dev         \
    libncurses5-dev     \
    libnfs-dev          \
    libnuma-dev         \
    libpixman-1-dev     \
    librbd-dev          \
    librdmacm-dev       \
    libsasl2-dev        \
    libsdl1.2-dev       \
    libseccomp-dev      \
    libsnappy-dev       \
    libssh2-1-dev       \
    libvde-dev          \
    libvdeplug-dev      \
    libvte-2.91-dev     \
    libxen-dev          \
    valgrind            \
    xfslibs-dev         \
    zlib1g-dev          \
    && sudo rm -rf /var/lib/apt/lists/*
