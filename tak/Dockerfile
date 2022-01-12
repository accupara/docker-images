# Copyright (c) 2016-2021 Crave.io Inc. All rights reserved
FROM accupara/android:latest
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
    ant \
    autoconf \
    automake \
    build-essential \
    cmake \
    curl \
    dos2unix \
    git \
    libtool \
    make \
    openjdk-8-jdk \
    patch \
    python3-pip \
    snap \
    swig \
    tcl8.6 \
    vim \
    wget \
    zip \
# Install the NDK that TAK needs
 && yes | sdkmanager \
 "ndk;21.0.6113669" \
# Install conan and self detect
 && sudo python3 -m pip install conan \
 && conan profile new default --detect \
# Minimize image
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

# Override the base image's NDK to the one that TAK requires
ENV ANDROID_NDK=/opt/android/ndk/android-ndk-r12b \
    NDK_TOOLS_VER=android-ndk-r12b
