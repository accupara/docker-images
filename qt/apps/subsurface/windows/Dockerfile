# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04

RUN buildDeps=' \
      autoconf \
      automake \
      autopoint \
      bash \
      bison \
      bzip2 \
      flex \
      gettext\
      git \
      g++ \
      gperf \
      intltool \
      libffi-dev \
      libgdk-pixbuf2.0-dev \
      libtool-bin \
      libltdl-dev \
      libssl-dev \
      libxml-parser-perl \
      make \
      openssl \
      p7zip-full \
      patch \
      perl \
      pkg-config \
      python \
      ruby \
      scons \
      sed \
      unzip \
      wget \
      xz-utils \
      g++-multilib \
      libc6-dev-i386 \
      xutils-dev \
    ' \
    && sudo apt-get -y update && sudo apt-get install -y --no-install-recommends $buildDeps \
    && sudo rm -rf /var/lib/apt/lists/* \
    && cd /opt && sudo git clone https://github.com/mxe/mxe \
    && sudo chown -R admin.admin /opt/mxe

COPY settings.mk /opt/mxe/
RUN cd /opt/mxe && make --jobs=4 libxml2 libxslt libusb1 libzip qt5 nsis curl


ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Subsurface for Windows" \
      org.label-schema.description="Build environment for cross-compiling Subsurface for Windows" \
      org.label-schema.url="https://www.accupara.com/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_REF \
      org.label-schema.vendor="Accupara Inc."
