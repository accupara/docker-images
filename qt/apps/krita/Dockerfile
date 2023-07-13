# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/qt5:ubuntu_2204

ENV CMAKE_VER=3.26.4 \
    BOOST_VER=1_82_0 \
    BOOST_ROOT=/opt/boost_1_82_0

RUN set -x \
 && sudo apt-get update \
# Install dependencies that have been identified from cmake failures
 && sudo apt-get install -y \
      cmake \
      extra-cmake-modules \
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
      qtquickcontrols2-5-dev \
      xorg-dev \
# Place for all the deps
 && mkdir -p /tmp/deps \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/deps/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Download boost, and compile it
 && wget -q -O /tmp/deps/boost_${BOOST_VER}.tar.gz https://downloads.sourceforge.net/project/boost/boost/$(echo ${BOOST_VER} | sed 's/_/./g')/boost_${BOOST_VER}.tar.gz >/dev/null \
 && sudo tar -C /opt -xf /tmp/deps/boost_${BOOST_VER}.tar.gz \
 && rm /tmp/deps/boost_${BOOST_VER}.tar.gz \
 && sudo chown -R admin:admin /opt/boost_${BOOST_VER} \
 && cd /opt/boost_${BOOST_VER} \
 && ./bootstrap.sh \
 && ./b2 \
# Download and install immer, zug, lager
 && cd /tmp/deps \
 && git clone https://github.com/arximboldi/immer.git immer \
 && git clone https://github.com/arximboldi/zug.git zug \
 && git clone https://github.com/arximboldi/lager.git lager \
 && for i in immer zug ; do \
        cd /tmp/deps/${i} && mkdir build && cd build && cmake .. && sudo make install ; \
    done \
# Cleanup all deps temp files
 && cd /tmp \
 && sudo find /tmp/deps -delete
