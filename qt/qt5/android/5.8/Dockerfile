# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/android
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY installqt.qs /tmp/installqt.qs

RUN sudo apt-get update

# Download the last version of Qt that works for Android (5.8.0) from here: https://www.qt.io/download-open-source/#section-2
RUN sudo apt-get install -y \
    wget \
    unzip \
 && wget http://download.qt.io/archive/qt/5.8/5.8.0/qt-opensource-linux-x64-android-5.8.0.run \
 && chmod +x qt-opensource-linux-x64-android-5.8.0.run \
 && sudo ./qt-opensource-linux-x64-android-5.8.0.run --script /tmp/installqt.qs --platform minimal \
 && rm qt-opensource-linux-x64-android-5.8.0.run
