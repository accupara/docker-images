# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/qt4:linux

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        libcurl4-openssl-dev \
        libboost-dev \
        libhunspell-dev \
        libopencv-dev \
        libpoppler-qt4-dev

