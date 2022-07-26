# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/qt4:linux

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        libqtwebkit-dev \
        libtelepathy-qt4-dev \
        perl \
        qt4-default
