# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM us.gcr.io/crave-228104/android:latest

RUN set -x \
 && sudo apt-get update \
# Purge JDK 11.
 && sudo apt-get purge -y openjdk-11-jre* || true \
 && sudo apt-get install -y \
    ant \
    autoconf \
    automake \
    build-essential \
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
# Install the NDK that TAK needs as well as the Build tools that the gradle section requires
 && yes | sdkmanager \
 "ndk;21.0.6113669" \
 "build-tools;30.0.2" \
 "platforms;android-29" \
 "cmake;3.18.1" \
# Install conan and self detect
 && sudo python3 -m pip install conan \
 && conan profile new default --detect \
# Minimize image
 && sudo apt-get autoremove -y \
 && sudo apt-get clean -y \
 && sudo rm -rf /var/lib/apt/lists/*

# Override the base image's NDK to the one that TAK requires
ENV ANDROID_NDK=/opt/android/ndk/android-ndk-r12b \
    ANDROID_NDK_HOME=/opt/android/ndk/android-ndk-r12b \
    NDK_TOOLS_VER=android-ndk-r12b \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/android/cmdline-tools/latest:/opt/android/cmdline-tools/latest/bin:/opt/android/cmake/3.18.1/bin
