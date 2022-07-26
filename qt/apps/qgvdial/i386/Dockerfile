# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/qt5:linux32

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        libc6-amd64 \
        libtelepathy-qt5-dev \
        perl \
        qt5-default
