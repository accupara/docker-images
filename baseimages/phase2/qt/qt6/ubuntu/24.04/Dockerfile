# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:24.04

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get -y install \
       libqt6websockets6-dev \
       libssl-dev \
       qmake6 \
       qt6-base-dev \
       qt6-declarative-dev \
       qt6-multimedia-dev \
       qt6-webengine-dev \
       qt6-webview-dev \
# Clean up image
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*

