# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/qt5:linux
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y \
        libqt5svg5-dev \
        qtscript5-dev
