# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/qt5:linux
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update

# libgit2-dev has to be installed after the rest
RUN sudo apt-get install -y \
    autoconf \
    automake \
    cmake \
    g++ \
    git \
    libcrypto++-dev \
    libcurl4-openssl-dev \
    libqt5qml5 \
    libqt5quick5 \
    libqt5svg5-dev \
    libqt5webkit5-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libssl-dev \
    libtool \
    libusb-1.0-0-dev \
    libxml2-dev \
    libxslt1-dev \
    libzip-dev \
    make \
    pkg-config \
    qt5-default \
    qt5-qmake \
    qtchooser \
    qtconnectivity5-dev \
    qtdeclarative5-dev \
    qtlocation5-dev \
    qtpositioning5-dev \
    qtscript5-dev \
    qttools5-dev \
    qttools5-dev-tools \
 && sudo apt-get install -y \
    libgit2-dev
