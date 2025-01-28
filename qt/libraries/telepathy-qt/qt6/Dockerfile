# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/qt6:ubuntu_2404

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
      cmake \
      doxygen \
      qt6-tools-dev-tools \
      libfarstream-0.2-dev \
      libqt6xml6t64 \
      libtelepathy-glib-dev \
      libtelepathy-farstream-dev \
      ninja-build
