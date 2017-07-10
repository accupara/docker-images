# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/android
MAINTAINER Accupara Inc. "contact@accupara.com"

COPY installqt.qs /tmp/installqt.qs

RUN sudo apt-get update

# Links information
# 1. Android Studio download page: https://developer.android.com/studio/index.html#downloads
#    "Just get the nd line tools"
# 2. Android NDK Download page: https://developer.android.com/ndk/downloads/index.html
# 3. Download the last version of Qt that works for Android (5.8.0) from here: https://www.qt.io/download-open-source/#section-2
RUN sudo apt-get install -y \
    wget \
    unzip \
 && wget http://download.qt.io/archive/qt/5.8/5.8.0/qt-opensource-linux-x64-android-5.8.0.run \
 && chmod +x qt-opensource-linux-x64-android-5.8.0.run \
 && sudo ./qt-opensource-linux-x64-android-5.8.0.run --script /tmp/installqt.qs --platform minimal \
 && rm qt-opensource-linux-x64-android-5.8.0.run
