# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/android_qt:5.9
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update

# libgit2-dev has to be installed after the rest
RUN sudo apt-get install -y \
    autoconf \
    automake \
    cmake \
    g++ \
    git \
    make \
    pkgconf \
 && sudo sed -i \
    's/set_property(TARGET Qt5::Core PROPERTY INTERFACE_COMPILE_FEATURES cxx_decltype)/# set_property(TARGET Qt5::Core PROPERTY INTERFACE_COMPILE_FEATURES cxx_decltype)/' \
    /opt/android-tools/Qt/5.9.1/android_armv7/lib/cmake/Qt5Core/Qt5CoreConfigExtras.cmake

ENV ANDROID_NDK_ROOT=/opt/android-tools/android-ndk-r14b \
    ANDROID_SDK_ROOT=/opt/android-tools \
    QT5_ANDROID=/opt/android-tools/Qt/5.9.1 \
    ANDROID_NDK=android-ndk-r14b \
    ANDROID_SDK=android-sdk-linux
