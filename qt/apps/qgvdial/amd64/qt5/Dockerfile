# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/qt5:linux

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        libqtwebkit-dev \
        libqt5webkit5-dev \
        libtelepathy-qt5-dev \
        perl \
        qt5-default
