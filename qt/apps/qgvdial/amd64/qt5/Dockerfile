# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/qt5:linux
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libqtwebkit-dev \
        libqt5webkit5-dev \
        libtelepathy-qt5-dev \
        perl \
        qt5-default
