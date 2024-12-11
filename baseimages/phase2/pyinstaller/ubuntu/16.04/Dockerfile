# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
   libffi-dev \
   python3-dev \
   python3-pip \
   python3-setuptools \
# Prepare a scratch area for downloading and compiling some projects
 && mkdir /tmp/scratch \
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
 && sudo ldconfig -v \
# Download and install python 3.8 because centos 7 has a very old python: 3.6
 && cd /tmp/scratch \
 && export PYTHON_VER=3.10.12 \
 && wget -q --no-check-certificate http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd /tmp/scratch/Python-${PYTHON_VER} \
 && ./configure --prefix=/usr --enable-shared --with-openssl=/usr LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j `nproc` \
 && sudo make altinstall \
# Reconfig after installing
 && sudo ldconfig -v \
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
