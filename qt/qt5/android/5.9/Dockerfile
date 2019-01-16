# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/android
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY installqt.qs /tmp/installqt.qs

RUN sudo apt-get update

# Download the last version of Qt that works for Android (5.9.1) from here: https://www.qt.io/download-open-source/#section-2
RUN sudo apt-get install -y \
    wget \
    unzip \
 && wget http://download.qt.io/archive/qt/5.9/5.9.1/qt-opensource-linux-x64-5.9.1.run \
 && chmod +x qt-opensource-linux-x64-5.9.1.run \
 && sudo ./qt-opensource-linux-x64-5.9.1.run --script /tmp/installqt.qs --platform minimal \
 && rm qt-opensource-linux-x64-5.9.1.run
