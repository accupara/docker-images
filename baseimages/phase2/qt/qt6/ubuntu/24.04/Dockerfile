# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
       libqt6statemachine6 \
       libqt6webview6 \
       libqt6webviewquick6 \
       libqt6websockets6-dev \
       libssl-dev \
       qmake6 \
       qt6-base-dev \
       qt6-declarative-dev \
       qt6-multimedia-dev \
       qt6-pdf-dev \
       qt6-positioning-dev \
       qt6-quick3d-dev \ 
       qt6-tools-dev \
       qt6-webchannel-dev \
       qt6-webengine-dev \
       qt6-websockets-dev \
       qt6-webview-dev \
       qtchooser \
# Choose QT6: From https://askubuntu.com/questions/1460242/ubuntu-22-04-with-qt6-qmake-could-not-find-a-qt-installation-of
 && qtchooser -install qt6 $(which qmake6) \
 && sudo mv ~/.config/qtchooser/qt6.conf /usr/share/qtchooser/qt6.conf \
 && sudo mkdir -p /usr/lib/$(uname -p)-linux-gnu/qt-default/qtchooser \
 && sudo ln -n /usr/share/qtchooser/qt6.conf /usr/lib/$(uname -p)-linux-gnu/qt-default/qtchooser/default.conf \
# Clean up image
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
