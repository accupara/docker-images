# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

ENV AR=aarch64-none-linux-gnu-ar \
    AS=aarch64-none-linux-gnu-as \
    LD=aarch64-none-linux-gnu-ld \
    RANLIB=aarch64-none-linux-gnu-ranlib \
    CC=aarch64-none-linux-gnu-gcc \
    NM=aarch64-none-linux-gnu-gcc-nm \
    GCC_ARM_VER=10.3-2021.07 \
    CURL_VER=7.80.0 \
    LIBXML_VER=2.9.12

# These two are separate because they depend on the values from the previous one...
ENV GCC_ARM_DIR=/opt/gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu
ENV PATH=${GCC_ARM_DIR}/bin:${PATH}

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && sudo eatmydata apt-get update -y \
 && sudo eatmydata apt-get install -y \
    gcc-multilib \
    xz-utils \
    wget \
# Get the cross-compiler directly from ARM
 && wget -q --no-check-certificate https://developer.arm.com/-/media/Files/downloads/gnu-a/${GCC_ARM_VER}/binrel/gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu.tar.xz \
 && tar -xf gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu.tar.xz \
 && rm gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu.tar.xz \
 && sudo mv $(readlink -f gcc-arm-${GCC_ARM_VER}-x86_64-aarch64-none-linux-gnu) /opt/ \
 && sudo chown -R admin:admin /opt/ \
# Create temp directory in which to download stuff
 && mkdir -p /tmp/dl \
# Download, extract and copy the appropriate files from each deb into the gcc_arm_dir
# libnghttp2-dev
 && cd /tmp/dl \
 && wget -q http://ports.ubuntu.com/ubuntu-ports/pool/main/n/nghttp2/libnghttp2-dev_1.30.0-1ubuntu1_arm64.deb \
 && ar xv libnghttp2-dev_1.30.0-1ubuntu1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libnghttp2.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libidn2-dev
 && wget -q http://ports.ubuntu.com/pool/main/libi/libidn2/libidn2-dev_2.0.4-1.1build2_arm64.deb \
 && ar xv libidn2-dev_2.0.4-1.1build2_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libidn2.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# librtmp-dev
 && wget -q http://ports.ubuntu.com/pool/main/r/rtmpdump/librtmp-dev_2.4+20151223.gitfa8646d.1-1_arm64.deb \
 && ar xv librtmp-dev_2.4+20151223.gitfa8646d.1-1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/librtmp.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libpsl-dev
 && wget -q http://ports.ubuntu.com/pool/main/libp/libpsl/libpsl-dev_0.19.1-5build1_arm64.deb \
 && ar xv libpsl-dev_0.19.1-5build1_arm64.deb  \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libpsl.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# nettle-dev
 && wget -q http://ports.ubuntu.com/pool/main/n/nettle/nettle-dev_3.4-1_arm64.deb \
 && ar xv nettle-dev_3.4-1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libnettle.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libgnutls28-dev
 && wget -q http://ports.ubuntu.com/pool/main/g/gnutls28/libgnutls28-dev_3.5.18-1ubuntu1_arm64.deb \
 && ar xv libgnutls28-dev_3.5.18-1ubuntu1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libgnutls.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# libldap2-dev
 && wget -q http://ports.ubuntu.com/pool/main/o/openldap/libldap2-dev_2.4.45+dfsg-1ubuntu1_arm64.deb \
 && ar xv libldap2-dev_2.4.45+dfsg-1ubuntu1_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/liblber.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
 && cp usr/lib/aarch64-linux-gnu/libldap.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# zlib1g-dev
 && wget -q http://ports.ubuntu.com/pool/main/z/zlib/zlib1g-dev_1.2.11.dfsg-0ubuntu2_arm64.deb \
 && ar xv zlib1g-dev_1.2.11.dfsg-0ubuntu2_arm64.deb \
 && tar xvf data.tar.xz \
 && cp usr/lib/aarch64-linux-gnu/libz.a ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# Download and build libcurl
 && cd /tmp/dl \
 && wget -q --no-check-certificate https://curl.se/download/curl-${CURL_VER}.tar.gz \
 && tar xvf curl-${CURL_VER}.tar.gz \
 && cd curl-${CURL_VER} \
 && ./configure --build x86_64-pc-linux-gnu --host aarch64-linux-gnu --with-gnutls --prefix=${GCC_ARM_DIR}/lib/ --enable-static  \
 && make -j `nproc` \
 && make install \
 && cp ${GCC_ARM_DIR}/lib/lib/libcurl.* ${GCC_ARM_DIR}/aarch64-none-linux-gnu/libc/lib64/. \
# The following library is for parsing XML in the AGF application.
# Download and build libxml2
 && cd /tmp/dl \
 && wget -q http://xmlsoft.org/sources/libxml2-${LIBXML_VER}.tar.gz \
 && tar xvfz libxml2-${LIBXML_VER}.tar.gz \
 && cd libxml2-${LIBXML_VER} \
 && ./configure --build x86_64-pc-linux-gnu --host aarch64-linux-gnu --prefix=${GCC_ARM_DIR}/lib/ --enable-static \
 && make -j `nproc` \
 && make install \
# Cleanup
 && cd /tmp/ \
 && find dl -delete