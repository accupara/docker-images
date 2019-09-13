# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && sudo apt-get update \
# Prep for Mono installation
 && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
 && sudo apt-get install -y apt-transport-https ca-certificates \
 && echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
# Latest version of cmake required for compilation
 && wget -O /tmp/cmake-3.15.3-Linux-x86_64.sh https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3-Linux-x86_64.sh \
 && chmod +x /tmp/cmake-3.15.3-Linux-x86_64.sh \
 && sudo /tmp/cmake-3.15.3-Linux-x86_64.sh --skip-license --prefix=/usr \
# Now for the rest of the deps
 && sudo apt update \
 && sudo apt-get install -y \
    libc++-dev \
    mono-devel \
    openjdk-8-jdk \
    software-properties-common \
# Install gcc 7
 && sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test \
 && sudo apt update \
 && sudo apt install -y g++-7 \
# Use gcc7 as the default
 && sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7 \
 && sudo update-alternatives --config gcc \
# Download boost, but don't compile it
 && wget -O /tmp/boost_1_67_0.tar.gz https://downloads.sourceforge.net/project/boost/boost/1.67.0/boost_1_67_0.tar.gz >/dev/null \
 && sudo tar -C /opt -xf /tmp/boost_1_67_0.tar.gz \
 && rm /tmp/boost_1_67_0.tar.gz \
 && sudo chown -R admin:admin /opt/boost_1_67_0 \
# Cleanup apt cache
 && sudo apt-get clean

ENV BOOST_ROOT=/opt/boost_1_67_0
