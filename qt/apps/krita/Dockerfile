# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/qt5:ubuntu_2204

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9 \
    BOOST_VER=1_84_0

SHELL [ "/bin/bash", "-c" ]

COPY build.mk /tmp/

RUN set -x \
 && cd /tmp \
 && make -f build.mk CMAKE_VER=${CMAKE_VER} BOOST_VER=${BOOST_VER} prep clean_deps

RUN set -x \
# Sip headers from pyqt5
 && pushd /usr/lib/python3/dist-packages/PyQt5/bindings/ \
 && find . -mindepth 1 -maxdepth 1 -type d | \
    while read line ; do \
        if [ -d $line ] ; then \
            sudo mkdir -p /usr/include/x86_64-linux-gnu/qt5/$line ; \
        fi ; \
        pushd /usr/include/x86_64-linux-gnu/qt5/$line ; \
        find /usr/lib/python3/dist-packages/PyQt5/bindings/$line | \
        while read line2 ; do \
            sudo ln -sf $line2 ; \
        done ; \
        popd ; \
    done \
 && popd \
# Place for all the deps
 && mkdir -p /tmp/deps \
# Install boost.python
 && cd /tmp/deps \
 && git clone https://github.com/boostorg/python.git boost.python \
 && cd boost.python/build \
# && cmake -G Ninja .. \
# Download and install SeExpr
 && cd /tmp/deps \
 && git clone https://github.com/wdas/SeExpr seexpr \
 && cd /tmp/deps/seexpr \
# && make all \
# Cleanup all deps temp files
 && cd /tmp \
 && sudo find /tmp/deps -delete

# Build command: cmake -G Ninja ../krita -DCMAKE_INSTALL_PREFIX=$HOME/kritadev/install -DCMAKE_BUILD_TYPE=Debug -DKRITA_DEVS=ON ; 
