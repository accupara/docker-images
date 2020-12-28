# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/debian:8
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo apt-get install -y \
    apt \
    apt-cacher-ng \
    apt-file \
    apt-transport-https \
    apt-utils \
    autoconf \
    automake \
    autotools-dev \
    bash-completion \
    bc \
    bind9-host \
    binfmt-support \
    bison \
    bsdmainutils \
    build-essential \
    ccache \
    cdbs \
    chrpath \
    cmake \
    cpio \
    cryptsetup-bin \
    debhelper \
    device-tree-compiler \
    devscripts \
    dh-autoreconf \
    dh-systemd \
    dialog \
    dosfstools \
    dpkg-sig \
    emacs \
    file \
    flex \
    gawk \
    gcc \
    gdb \
    genisoimage \
    git \
    gperf \
    g++ \
    hardening-wrapper \
    ifupdown \
    iproute \
    iputils-ping \
    isolinux \
    kmod \
    less \
    libboost-all-dev \
    libc6-dev \
    libcap-dev \
    libcurl4-nss-dev \
    libc-ares-dev \
    libdouble-conversion-dev \
    libedit-dev \
    libelf-dev \
    libevent-dev \
    libexpat1-dev \
    libgoogle-glog-dev \
    libi2c-dev \
    libjson0 \
    libjson0-dev \
    libjson-c-dev \
    libkrb5-dev \
    libnuma-dev \
    libpam0g-dev \
    libpam-dev \
    libpcap-dev \
    libpcre3-dev \
    libreadline-dev \
    libsasl2-dev \
    libsnappy-dev \
    libsnmp-dev \
    libssl-dev \
    libstdc++6 \
    libsystemd-dev \
    libtool \
    libtool-bin \
    libusb-dev \
    libxml2-dev \
    linux-perf-4.9 \
    linux-tools-3.16 \
    linux-tools \
    locales \
    lsof \
    make \
    mingetty \
    mtd-utils \
    mtools \
    multistrap \
    nano \
    ncurses-dev \
    netbase \
    net-tools \
    nfs-common \
    openssh-server \
    pkg-config \
    procps \
    psmisc \
    python \
    python-debian \
    python-dev \
    python-dnspython \
    python-yaml \
    qemu \
    qemu-user-static \
    realpath \
    rsyslog \
    ruby \
    ruby-dev \
    rubygems \
    screen \
    squashfs-tools \
    sshpass \
    stgit \
    sudo \
    swig \
    syslinux-utils \
    tcpreplay \
    telnet \
    texinfo \
    texlive-generic-recommended \
    texlive-latex-base \
    traceroute \
    tshark \
    u-boot-tools \
    vim-tiny \
    wget \
    xorriso \
    zile \
    zip \
 && echo "deb https://emdebian.metrotek.center/ jessie main" | sudo tee /etc/apt/sources.list.d/crosstools.list \
 && curl https://emdebian.metrotek.center/emdebian-toolchain-archive.key | sudo apt-key add - \
 && sudo dpkg --add-architecture armel \
 && sudo dpkg --add-architecture arm64 \
# && sudo dpkg --add-architecture powerpc \ # powerpc no longer supported on Jessie
 && sudo apt-get update \
 && sudo apt-get install -y \
    cross-gcc-dev \
    crossbuild-essential-armel \
    crossbuild-essential-arm64 \
    gcc-arm-linux-gnueabi \
    gcc-aarch64-linux-gnu \
# Compile and install Ruby
 && cd /tmp/ \
 && export VER=2.7.2 \
 && wget https://cache.ruby-lang.org/pub/ruby/2.7/ruby-$VER.tar.gz \
 && tar -xf ruby-$VER.tar.gz \
 && cd ruby-$VER \
 && ./configure \
 && make -j `nproc` \
 && sudo make install \
 && cd .. && rm -rf ruby-$VER \
# Gem install
 && sudo gem install --version 1.3.3 fpm \
#
# The i2c-dev.h user/kernel header conflict is a nightmare.
#
# The ONLP implementation expects a new file called <linux/i2c-device.h> to be in place which contains the correct user-space driver definitions.
# This should be manually populated here after the toolchains have been installed.
#
 && sudo cp /usr/include/linux/i2c-dev.h /usr/include/linux/i2c-devices.h \
 && sudo cp /usr/include/linux/i2c-dev.h /usr/powerpc-linux-gnu/include/linux/i2c-devices.h \
# qemu: aarch64
 && wget http://www.opennetlinux.org/tarballs/usr-bin-qemu-aarch64-static.tgz \
 && sudo tar -C / -xvzf usr-bin-qemu-aarch64-static.tgz \
 && rm usr-bin-qemu-aarch64-static.tgz \
# qemu: arm64
 && wget http://www.opennetlinux.org/tarballs/jessie-usr-buildroot-toolchains-arm64.tgz \
 && sudo tar -C / -xvzf jessie-usr-buildroot-toolchains-arm64.tgz \
 && rm jessie-usr-buildroot-toolchains-arm64.tgz \
# LTS architecture fixes
 && sudo sed -i s/'http:\/\/security'/'[arch=amd64,armel] http:\/\/security'/g /etc/apt/sources.list \
 && sudo apt-get update \
 && apt-get upgrade -y

#RUN set -x \
# && sudo apt-get clean -y \
# && sudo rm -rf /var/lib/apt/lists/* \
