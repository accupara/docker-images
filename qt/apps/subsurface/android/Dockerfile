# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/android_qt:5.9
MAINTAINER Accupara Inc. "contact@accupara.com"

# libgit2-dev has to be installed after the rest
RUN sudo apt-get update && sudo apt-get install -y \
    autoconf \
    automake \
    cmake \
    extra-cmake-modules \
    g++ \
    git \
    make \
    pkgconf \
    libtool-bin \
    libtool \
 && sudo apt-get -y install libgit2-dev \
 && sudo sed -i \
    's/set_property(TARGET Qt5::Core PROPERTY INTERFACE_COMPILE_FEATURES cxx_decltype)/# set_property(TARGET Qt5::Core PROPERTY INTERFACE_COMPILE_FEATURES cxx_decltype)/' \
    /opt/android-tools/Qt/5.9.1/android_armv7/lib/cmake/Qt5Core/Qt5CoreConfigExtras.cmake

ENV ANDROID_NDK_ROOT=/opt/android-tools/android-ndk-r14b \
    ANDROID_SDK_ROOT=/opt/android-tools \
    QT5_ANDROID=/opt/android-tools/Qt/5.9.1 \
    ANDROID_NDK=android-ndk-r14b \
    ANDROID_SDK=android-sdk-linux

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Subsurface for Android" \
      org.label-schema.description="Build environment for compiling Subsurface for Android" \
      org.label-schema.url="https://www.accupara.com/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_REF \
      org.label-schema.vendor="Accupara Inc."
