# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/qt5:ubuntu_2404

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
       libdbusextended-qt5-dev \
       libqt5xmlpatterns5-dev \
       libtelepathy-glib-dev
