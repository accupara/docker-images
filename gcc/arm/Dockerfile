# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

ENV GCC_ARM_VER=10.3-2021.07

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update -y \
 && sudo eatmydata apt-get install -y \
    xz-utils \
    wget \
# Get the cross-compiler directly from ARM
 && wget --no-check-certificate https://developer.arm.com/-/media/Files/downloads/gnu-a/${GCC_ARM_VER}/binrel/gcc-arm-$(GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu.tar.xz \
 && tar -xf gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu.tar.xz \
 && rm gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu.tar.xz \
 && export GCC_ARM_DIR=$(readlink -f gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu) \
# Create temp directory in which to download stuff
 && mkdir -p /tmp/dl \
# Download, extract and copy the appropriate files from each deb into the gcc_arm_dir
# libnghttp2-dev
 && cd /tmp/dl \
 && wget http://ports.ubuntu.com/ubuntu-ports/pool/main/n/nghttp2/libnghttp2-dev_1.30.0-1ubuntu1_arm64.deb \
 && ar xv libnghttp2-dev_1.30.0-1ubuntu1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libnghttp2.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libidn2-dev
 && wget http://ports.ubuntu.com/pool/main/libi/libidn2/libidn2-dev_2.0.4-1.1build2_arm64.deb \
 && ar xv libidn2-dev_2.0.4-1.1build2_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libidn2.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# librtmp-dev
 && wget http://ports.ubuntu.com/pool/main/r/rtmpdump/librtmp-dev_2.4+20151223.gitfa8646d.1-1_arm64.deb \
 && ar xv librtmp-dev_2.4+20151223.gitfa8646d.1-1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/librtmp.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libpsl-dev
 && wget http://ports.ubuntu.com/pool/main/libp/libpsl/libpsl-dev_0.19.1-5build1_arm64.deb \
 && ar xv libpsl-dev_0.19.1-5build1_arm64.deb  \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libpsl.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# nettle-dev
 && wget http://ports.ubuntu.com/pool/main/n/nettle/nettle-dev_3.4-1_arm64.deb \
 && ar xv nettle-dev_3.4-1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libnettle.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libgnutls28-dev
 && wget http://ports.ubuntu.com/pool/main/g/gnutls28/libgnutls28-dev_3.5.18-1ubuntu1_arm64.deb \
 && ar xv libgnutls28-dev_3.5.18-1ubuntu1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libgnutls.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libldap2-dev
 && wget http://ports.ubuntu.com/pool/main/o/openldap/libldap2-dev_2.4.45+dfsg-1ubuntu1_arm64.deb \
 && ar xv libldap2-dev_2.4.45+dfsg-1ubuntu1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/liblber.a ~/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu/libc/lib64/. \
 && cp usr/lib/aarch64-linux-gnu/libldap.a ~/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu/libc/lib64/. \
# zlib1g-dev
 && wget http://ports.ubuntu.com/pool/main/z/zlib/zlib1g-dev_1.2.11.dfsg-0ubuntu2_arm64.deb \
 && ar xv zlib1g-dev_1.2.11.dfsg-0ubuntu2_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libz.a ~/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu/libc/lib64/.