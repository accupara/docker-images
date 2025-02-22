# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

ENV QT_VER=6.8.2

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
       qtchooser \
# Download Qt6 from the place we uploaded it
 && wget -q https://storage.googleapis.com/accupara_images/qt${QT_VER}.tar.gz \
 && sudo tar -xvf qt${QT_VER}.tar.gz -C /usr/local/ \
 && rm qt${QT_VER}.tar.gz \
# Choose QT6: From https://askubuntu.com/questions/1460242/ubuntu-22-04-with-qt6-qmake-could-not-find-a-qt-installation-of
 && qtchooser -install qt6 /usr/local/Qt-${QT_VER}/bin/qmake6 \
 && sudo mv ~/.config/qtchooser/qt6.conf /usr/share/qtchooser/qt6.conf \
 && sudo mkdir -p /usr/lib/$(uname -p)-linux-gnu/qt-default/qtchooser \
 && sudo ln -n /usr/share/qtchooser/qt6.conf /usr/lib/$(uname -p)-linux-gnu/qt-default/qtchooser/default.conf \
# Clean up image
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
