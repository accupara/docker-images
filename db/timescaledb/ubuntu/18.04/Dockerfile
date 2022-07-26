# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

ENV CMAKE_VER=3.23.2 \
    PGVER=12

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
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
        python \
        python-dev \
        python3-dev \
        python3 \
        readline-common \
        tcl \
        tcl-dev \
        zlib1g-dev \
        libxml2-utils \
        xsltproc \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Install PG 12
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
 && echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list \
 && sudo apt-get update \
 && sudo apt-get -y install \
    postgresql-${PGVER} \
    postgresql-client-${PGVER} \
    postgresql-server-dev-${PGVER} \
# Cleanup
 && sudo apt-get clean

# Timescale DB packages
#RUN sudo apt-get install -y \
#       cmake \
#       clang-format-7 \
#       postgresql \
#       postgresql-client \
#       postgresql-common \
#       postgresql-client-common \
#       postgresql-server-dev-all \
 # clang-format-7 does not create link to clang-format and that causes failure in bootstrap script of timescaledb
# && sudo ln -s /usr/bin/clang-format-7 /usr/bin/clang-format \
# && sudo apt-get clean
 
