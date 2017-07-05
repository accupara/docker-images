# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:17.04
MAINTAINER Accupara Inc. "contact@accupara.com"

COPY installqt.qs /tmp/installqt.qs

RUN sudo apt-get update

# Links information
# 1. Android Studio download page: https://developer.android.com/studio/index.html#downloads
#    "Just get the nd line tools"
# 2. Android NDK Download page: https://developer.android.com/ndk/downloads/index.html
# 3. Download the last version of Qt that works for Android (5.8.0) from here: https://www.qt.io/download-open-source/#section-2
RUN sudo apt-get install -y \
    libdbus-1-3 \
    libfontconfig1 \
    libgl1-mesa-glx \
    libx11-xcb1 \
    wget \
    unzip \
 && wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
         https://dl.google.com/android/repository/android-ndk-r15b-linux-x86_64.zip \
         http://download.qt.io/archive/qt/5.8/5.8.0/qt-opensource-linux-x64-android-5.8.0.run \
 && unzip sdk-tools-linux-3859397.zip \
 && unzip android-ndk-r15b-linux-x86_64.zip \
 && rm sdk-tools-linux-3859397.zip android-ndk-r15b-linux-x86_64.zip \
 && chmod +x qt-opensource-linux-x64-android-5.8.0.run \
 && sudo mkdir /opt/android-tools \
 && sudo mv android-ndk-r15b tools /opt/android-tools/ \
 && sudo ./qt-opensource-linux-x64-android-5.8.0.run --script /tmp/installqt.qs --platform minimal \
 && rm qt-opensource-linux-x64-android-5.8.0.run
