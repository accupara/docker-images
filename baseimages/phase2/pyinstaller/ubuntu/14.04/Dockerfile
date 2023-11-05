# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04

ENV PYTHON_VER=3.10.12 \
    PYTHON_VER_MAJOR=3.10

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
   libdb4o-cil-dev \
   libffi-dev \
   libgdm-dev \
   libncurses5-dev \
   libpcap-dev \
   libreadline-dev \
   libsqlite3-dev \
   libssl-dev \
   libtk8.6 \
   python3-dev \
   python3-pip \
   python3-setuptools \
# Prepare a scratch area for downloading and compiling some projects
 && mkdir -p /tmp/scratch \
# Download and install a version of SSL that python3 supports: 1.1.0 or better: 1.1.1u
 && export OPENSSL_VER=1.1.1u \
 && cd /tmp/scratch \
 && wget -q --no-check-certificate https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz \
 && tar -xf openssl-${OPENSSL_VER}.tar.gz \
 && cd openssl-${OPENSSL_VER} \
 && ./config --prefix=/usr --openssldir=/usr shared zlib \
 && make -j `nproc` \
 && sudo make install \
# Update the ldconfig for openssl
 && echo "/usr/lib" | sudo tee /etc/ld.so.conf.d/crave.conf \
 && echo "/usr/local/lib64" | sudo tee -a /etc/ld.so.conf.d/crave.conf \
 && sudo ldconfig -v \
# Download and install python 3.10
 && cd /tmp/scratch \
 && wget -q --no-check-certificate http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd /tmp/scratch/Python-${PYTHON_VER} \
 && ./configure --prefix=/usr --with-openssl=/usr --enable-shared \
 && make -j `nproc` \
 && sudo make install \
# Reconfig after installing
 && sudo ldconfig -v

RUN set -x \
# Make sure that lsb_release works correctly:
 #&& sudo sed -i "s/python3 /python${PYTHON_VER_MAJOR} /" /usr/bin/lsb_release \
 && wget -q https://bootstrap.pypa.io/get-pip.py \
 && sudo python3 get-pip.py \
# Use the new python to install all the deps for pyinstaller
 && sudo python3 -m pip install --upgrade pip \
 && sudo python3 -m pip install --upgrade setuptools wheel \
 && sudo python3 -m pip install --upgrade \
      autopep8 \
      boto3 \
      configparser \
      giturlparse.py \
      google-api-python-client \
      grpcio   \
      grpcio-tools \
      paramiko \
      pick \
      pyinstaller \
      python-dateutil \
      requests \
      scp \
      tabulate \
      termcolor \
      tzdata \
      tzlocal \
      websocket-client \
# Cleanup
 && cd /tmp \
 && sudo find /tmp/scratch -delete
