# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/centos:6
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo yum -y update \
 && sudo yum groupinstall -y "development tools" \
 && sudo yum install -y \
    bzip2-devel \
    db4-devel \
    expat-devel \
    gdbm-devel \
    libpcap-devel \
    ncurses-devel \
    openssl-devel \
    readline-devel \
    sqlite-devel \
    tk-devel \
    wget \
    xz-devel \
    zlib-devel \
 && export PYTHON_VER=3.8.2 \
 && wget http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd Python-${PYTHON_VER} \
 && ./configure --prefix=/usr/local --enable-shared --enable-optimizations LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j4 \
 && sudo make altinstall \
 && cd .. ; sudo rm -rf Python-${PYTHON_VER}*
