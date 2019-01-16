# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
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
 && export PYTHON_VER=3.6.6 \
 && wget http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd Python-${PYTHON_VER} \
 && ./configure --prefix=/usr/local --enable-shared --enable-optimizations LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j4 \
 && sudo make altinstall \
 && sudo /usr/local/bin/pip3.6 install \
    giturlparse.py \
    pick \
    pyinstaller \
    python-dateutil \
    requests \
    tabulate \
    termcolor \
    tzdata \
    tzlocal \
    websocket-client \
 && cd .. ; sudo rm -rf Python-${PYTHON_VER}*
