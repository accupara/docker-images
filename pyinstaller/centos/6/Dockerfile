# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/centos:6
MAINTAINER Accupara Inc. "contact@accupara.com"

RUN sudo yum -y update \
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
 && wget http://python.org/ftp/python/3.5.4/Python-3.5.4.tar.xz \
 && tar xf Python-3.5.4.tar.xz \
 && cd Python-3.5.4 \
 && ./configure --prefix=/usr/local --enable-shared --enable-optimizations LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j4 \
 && sudo make altinstall \
 && sudo /usr/local/bin/pip3.5 install \
    giturlparse.py \
    pyinstaller \
    requests \
    tabulate \
    termcolor \
    websocket-client \
 && cd .. ; sudo rm -rf Python-3.5.4*
