# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved
FROM accupara/qt5:ubuntu_2404

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
      cmake \
      doxygen \
      graphviz \
      libdbusextended-qt5-dev \
      libfarstream-0.2-dev \
      libqt5xmlpatterns5-dev \
      libtelepathy-glib-dev \
      libtelepathy-farstream-dev \
      ninja-build
