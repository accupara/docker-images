# Copyright (c) 2016-2018 Accupara Inc. All rights reserved
FROM accupara/qt5:linux
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libqt5svg5-dev \
        qtscript5-dev
