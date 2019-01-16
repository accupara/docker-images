# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/qt5:linux
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libqtwebkit-dev \
        libqt5webkit5-dev \
        libtelepathy-qt5-dev \
        perl \
        qt5-default
