# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/android
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
    pkgconf

ENV ANDROID_NDK_ROOT=/opt/android-tools/android-ndk-r15b \
    ANDROID_SDK_ROOT=/opt/android-tools/tools \
    QT5_ANDROID=/opt/android-tools/Qt/5.8
