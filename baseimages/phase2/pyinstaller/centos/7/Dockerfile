# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/centos:7

RUN set -x \
 && sudo yum -y update \
 #&& sudo yum groupinstall -y "development tools" \
 && sudo yum install -y \
    bzip2-devel \
    db4-devel \
    expat-devel \
    flex \
    gdbm-devel \
    glibc-devel.i686 \
    libffi-devel \
    libpcap-devel \
    ncurses-devel \
    readline-devel \
    sqlite-devel \
    tk-devel \
    wget \
    xz-devel \
    zlib-devel \
# Prepare a scratch area for downloading and compiling some projects
 && mkdir /tmp/scratch \
# Download and install the latest gcc
 && export GCC_VER=9.2.0 \
 && cd /tmp/scratch \
 && mkdir GCC-source && cd GCC-source \
# Get Crave
 && curl -s https://raw.githubusercontent.com/accupara/crave/master/get_crave.sh | bash -s -- \
 && export CRAVE=$(readlink -f crave) \
# Get GCC source
 && git clone git://gcc.gnu.org/git/gcc.git gcc \
 && cd gcc \
 && git checkout releases/gcc-${GCC_VER} \
 && export SRC=$(readlink -f .) \
 && $SRC/contrib/download_prerequisites \
 && mkdir -p ../build && cd ../build \
 && $SRC/configure --disable-multilib \
 && make -j `nproc` \
 && sudo make install \
 && gcc --version 2>&1 | tee /tmp/gcc-version.txt \
# Download and install a version of SSL that python3 supports: 1.1.0 or better: 1.1.1u
 && export OPENSSL_VER=1.1.1u \
 && cd /tmp/scratch \
 && wget -q --no-check-certificate https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz \
 && tar -xf openssl-${OPENSSL_VER}.tar.gz \
 && cd openssl-${OPENSSL_VER} \
 && ./config --prefix=/usr --openssldir=/usr shared zlib \
 && make -j `nproc` \
 && sudo make install \
# Update the ldconfig for openssl and gcc
 && echo "/usr/lib" | sudo tee /etc/ld.so.conf.d/crave.conf \
 && echo "/usr/local/lib64" | sudo tee -a /etc/ld.so.conf.d/crave.conf \
 && sudo ldconfig -v \
# Download and install python 3.8 because centos 7 has a very old python: 3.6
 && cd /tmp/scratch \
 && export PYTHON_VER=3.8.10 \
 && wget -q --no-check-certificate http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd /tmp/scratch/Python-${PYTHON_VER} \
 && ./configure --prefix=/usr --enable-shared --with-openssl=/usr LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j `nproc` \
 && sudo make altinstall \
# Reconfig after installing
 && sudo ldconfig -v \
# Now pip install the usual suspects required for pyinstaller
 && sudo /usr/bin/python3.8 -m pip install --upgrade pip \
 && sudo /usr/bin/python3.8 -m pip install --upgrade \
    giturlparse \
    pick \
    pipenv \
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
 && sudo ln -s python3.8 python3 \
# Cleanup
 && cd /tmp \
 && sudo find /tmp/scratch -delete
