# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/centos:6

RUN set -x \
 && sudo yum -y update \
 && sudo yum groupinstall -y "development tools" \
 && sudo yum install -y \
    bzip2-devel \
    db4-devel \
    expat-devel \
    flex \
    gdbm-devel \
    glibc-devel.i686 \
    libgcc.i686 \
    libffi-devel \
    libpcap-devel \
    ncurses-devel \
    readline-devel \
    sqlite-devel \
    svn \
    texinfo-tex \
    tk-devel \
    wget \
    xz-devel \
    zip \
    zlib-devel \
# Prepare a scratch area for downloading and compiling some projects
 && mkdir /tmp/scratch \
# Download and install a version of SSL that python3 supports: 1.1.0 or better: 1.1.1m
 && export OPENSSL_VER=1.1.1m \
 && cd /tmp/scratch \
 && wget -q --no-check-certificate https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz \
 && tar -xf openssl-${OPENSSL_VER}.tar.gz \
 && cd openssl-${OPENSSL_VER} \
 && ./config --prefix=/usr --openssldir=/usr shared zlib \
 && make -j `nproc` \
 && sudo make install \
# Download and install python 3.8 because centos 6 has a very old python3
 && cd /tmp/scratch \
 && export PYTHON_VER=3.8.10 \
 && wget -q --no-check-certificate http://python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz \
 && tar xf Python-${PYTHON_VER}.tar.xz \
 && cd /tmp/scratch/Python-${PYTHON_VER} \
# Fixup SSL module info:
 && echo '_socket socketmodule.c' >>Modules/Setup \
 && echo 'SSL="/usr/lib64/openssl"' >>Modules/Setup \
 && echo '_ssl _ssl.c \' >>Modules/Setup \
 && echo '   -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \' >>Modules/Setup \
 && echo '   -L$(SSL)/lib -lssl -lcrypto' >>Modules/Setup \
 && ./configure --prefix=/usr/local --with-openssl=/usr/local/openssl --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" \
 && make -j `nproc` \
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
# Cleanup
 && cd /tmp \
 && sudo find /tmp/scratch -delete

 # GCC gets installed in /usr/local/bin. I don't want to figure out how to change that
 ENV PATH=/usr/local/bin:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
