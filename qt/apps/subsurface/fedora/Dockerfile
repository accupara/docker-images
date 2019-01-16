# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/fedora:26
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN sudo dnf -y install \
    git \
    gcc-c++ \
    make \
    autoconf \
    automake \
    libtool \
    cmake \
    libzip-devel \
    libxml2-devel \
    libxslt-devel \
    libsqlite3x-devel \
    libudev-devel \
    libusbx-devel \
    libcurl-devel \
    libssh2-devel \
    qt5-qtbase-devel \
    qt5-qtdeclarative-devel \
    qt5-qtscript-devel \
    qt5-qtwebkit-devel \
    qt5-qtsvg-devel \
    qt5-qttools-devel \
    qt5-qtconnectivity-devel \
    qt5-qtlocation-devel \
    redhat-rpm-config \
    qt5-devel \
    file \
    bash \
    bison \
    bzip2 \
    flex \
    gdk-pixbuf2-devel \
    gettext \
    gperf \
    intltool \
    sed \
    libffi-devel \
    openssl-devel \
    p7zip \
    patch \
    perl \
    pkgconfig \
    python \
    ruby \
    scons \
    unzip \
    wget \
    xz \
    && sudo dnf -y install @development-tools \
    && sudo dnf -y group install "C Development Tools and Libraries" \
    && sudo dnf clean all

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Subsurface for Fedora Linux" \
      org.label-schema.description="Build environment for compiling Subsurface for Fedora Linux AMD64" \
      org.label-schema.url="https://www.accupara.com/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_REF \
      org.label-schema.vendor="Crave.io Inc."

