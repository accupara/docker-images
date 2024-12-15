# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9 \
    PG_VER=15

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
        bison \
        build-essential \
        flex \
        gettext \
        libgettextpo0 \
        libkrb5-dev \
        libossp-uuid-dev \
        libpam0g-dev \
        libperl-dev \
        libreadline6-dev \
        libssl-dev \
        libtcl8.6 \
        libxml2-dev \
        libxslt1-dev \
        perl-modules \
        python3-dev \
        python3 \
        python-is-python3 \
        readline-common \
        tcl \
        tcl-dev \
        zlib1g-dev \
        libxml2-utils \
        xsltproc \
# Latest version of cmake required for compilation
 && export ARCH=$(uname -m) \
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-$ARCH.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh --skip-license --prefix=/usr \
# Install PG 12
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo eatmydata apt-key add - \
 && echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get -y install \
    postgresql-${PG_VER} \
    postgresql-client-${PG_VER} \
    postgresql-server-dev-${PG_VER} \
# Cleanup
 && sudo apt-get clean
