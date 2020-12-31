# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/centos:7
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo yum -y update \
 #&& sudo yum groupinstall -y "development tools" \
 && sudo yum install -y \
    bzip2-devel \
    db4-devel \
    expat-devel \
    gdbm-devel \
    libffi-devel \
    libpcap-devel \
    ncurses-devel \
    readline-devel \
    sqlite-devel \
    tk-devel \
    wget \
    xz-devel \
    zlib-devel \
# Download and install a version of SSL that python3 supports: 1.1.0 or better: 1.1.1g
 && cd /tmp/ \
 && wget -q https://github.com/openssl/openssl/archive/OpenSSL_1_1_1g.tar.gz \
 && tar -xf OpenSSL_1_1_1g.tar.gz \
 && cd openssl-OpenSSL_1_1_1g \
 && ./config --prefix=/usr --openssldir=/usr shared zlib \
 && make -j4 && sudo make install \
 && cd .. \
 && sudo rm -rf OpenSSL_1_1_1g.tar.gz openssl-OpenSSL_1_1_1g \
# Download and install python 3.8 because centos 7 has a very old python: 3.6
 && cd /tmp/ \
 && export PYTHON_VER=3.8.5 \
 && wget -q http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd /tmp/Python-${PYTHON_VER} \
# Fixup SSL module info:
 && echo '_socket socketmodule.c' >>Modules/Setup \
 && echo 'SSL="/usr/lib64/openssl"' >>Modules/Setup \
 && echo '_ssl _ssl.c \' >>Modules/Setup \
 && echo '   -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \' >>Modules/Setup \
 && echo '   -L$(SSL)/lib -lssl -lcrypto' >>Modules/Setup

RUN set -x \
 && cd /tmp/Python-3.8.5 \
 && ./configure --prefix=/usr/local --with-openssl=/usr/local/openssl --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j4 \
 && sudo make altinstall \
# Now pip install the usual suspects required for pyinstaller
 && sudo /usr/local/bin/python3.8 -m pip install --upgrade pip \
 && sudo /usr/local/bin/python3.8 -m pip install --upgrade \
    giturlparse \
    pick \
    pyinstaller \
    python-dateutil \
    requests \
    tabulate \
    termcolor \
    tzdata \
    tzlocal \
    websocket-client \
# Set up links
 && cd /usr/bin/ \
 && sudo ln -s /usr/local/bin/python3.8 \
 && sudo ln -s python3.8 python3 \
 && sudo ln -s /usr/local/bin/pip3.8 \
 && sudo ln -s pip3.8 pip3 \
# Cleanup the sources
 && cd .. && sudo rm -rf Python-${PYTHON_VER}*
