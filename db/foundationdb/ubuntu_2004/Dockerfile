# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

ENV BOOST_ROOT=/opt/boost_1_80_0 \
    BOOST_VER=1_80_0 \
    CMAKE_VER=3.23.2

RUN set -x \
 && sudo apt-get update \
# Prep for Mono installation
 && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
 && sudo apt-get install -y apt-transport-https ca-certificates \
 && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
# Latest version of cmake required for compilation
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-x86_64.sh --skip-license --prefix=/usr \
# Now for the rest of the deps
 && sudo apt update \
 && sudo apt-get install -y \
    libc++-dev \
    liblz4-dev \
    libssl-dev \
    mono-devel \
    ninja-build \
    openjdk-11-jdk \
    software-properties-common \
# Download boost, but don't compile it
 && wget -q -O /tmp/boost_${BOOST_VER}.tar.gz https://downloads.sourceforge.net/project/boost/boost/$(echo ${BOOST_VER} | sed 's/_/./g')/boost_${BOOST_VER}.tar.gz >/dev/null \
 && sudo tar -C /opt -xf /tmp/boost_${BOOST_VER}.tar.gz \
 && rm /tmp/boost_${BOOST_VER}.tar.gz \
 && sudo chown -R admin:admin /opt/boost_${BOOST_VER} \
# Cleanup apt cache
 && sudo apt-get clean
