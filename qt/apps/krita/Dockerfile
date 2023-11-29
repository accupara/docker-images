# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/qt5:ubuntu_2204

# Cmake: https://cmake.org/download/
ENV CMAKE_VER=3.27.9 \
    BOOST_VER=1_82_0

SHELL [ "/bin/bash", "-c" ]

RUN set -x \
 && sudo apt-get update \
# Install dependencies that have been identified from cmake failures
 && sudo apt-get install -y \
      cmake \
      extra-cmake-modules \
      libgsl-dev \
      libkdecorations2-dev \
      libkf5completion-dev \
      libkf5config-dev \
      libkf5coreaddons-dev \
      libkf5crash-dev \
      libkf5guiaddons-dev \
      libkf5i18n-dev \
      libkf5itemmodels-dev \
      libkf5itemviews-dev \
      libqt5quick5 \
      libqt5quickwidgets5 \
      libkf5widgetsaddons-dev \
      libkf5windowsystem-dev \
      libqt5svg5-dev \
      libqt5x11extras5-dev \
      libwebp-dev \
      ninja-build \
      pyqt5-dev \
      python3-pip \
      python3-qtpy \
      qtquickcontrols2-5-dev \
      sip-dev \
      ruby-sass \
      xorg-dev \
# Default python to python3
 && sudo update-alternatives --install /usr/local/bin/python python /usr/bin/python3 20 \
# Upgrade pip and then install deps
 && sudo python3 -m pip install --upgrade pip \
 && sudo python3 -m pip install numpy \
# Place for all the deps
 && mkdir -p /tmp/deps \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Download boost, and compile it
 && wget -q -O /tmp/deps/boost_${BOOST_VER}.tar.gz https://downloads.sourceforge.net/project/boost/boost/$(echo ${BOOST_VER} | sed 's/_/./g')/boost_${BOOST_VER}.tar.gz >/dev/null \
 && sudo tar -C /tmp/deps -xf /tmp/deps/boost_${BOOST_VER}.tar.gz \
 && sudo chown -R admin:admin /tmp/deps/boost_${BOOST_VER} \
 && cd /tmp/deps/boost_${BOOST_VER} \
 && ./bootstrap.sh --prefix=/usr \
 && ./b2 \
 && sudo ./b2 install \
# Download and install immer, zug, lager
 && cd /tmp/deps \
 && git clone https://github.com/arximboldi/immer.git immer \
 && git clone https://github.com/arximboldi/zug.git zug \
 && git clone https://github.com/arximboldi/lager.git lager \
 && for i in immer zug lager ; do \
        cd /tmp/deps/${i} && mkdir build && cd build && cmake .. && sudo make install ; \
    done \
# Install faber for boost.python
 && cd /tmp/deps \
 && git clone https://github.com/stefanseefeld/faber.git faber \
 && cd faber \
 && sudo python3 setup.py install \
# Cleanup all deps temp files
 && cd /tmp \
 && sudo find /tmp/deps -delete

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
