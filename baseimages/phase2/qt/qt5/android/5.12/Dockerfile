# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM us.gcr.io/crave-228104/android:latest

COPY installqt.qs /tmp/installqt.qs

# Download the last version of Qt that works for Android (5.9.1) from here: https://www.qt.io/download-open-source/#section-2
RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
    libxkbcommon-x11-0 \
    wget \
    unzip \
 && wget -q https://download.qt.io/archive/qt/5.12/5.12.12/qt-opensource-linux-x64-5.12.12.run \
 && chmod +x qt-opensource-linux-x64-5.12.12.run \
 && sudo ./qt-opensource-linux-x64-5.12.12.run --script /tmp/installqt.qs --platform minimal \
 && rm qt-opensource-linux-x64-5.12.12.run
