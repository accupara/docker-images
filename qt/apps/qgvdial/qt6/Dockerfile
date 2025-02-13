# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/qt6:ubuntu_2404

# Keep the update separate so that Docker build system can cache it.
RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
        libqt6statemachine6 \
        libqt6webview6 \
        libqt6webviewquick6 \
        qt6-webengine-dev \
        qt6-webview-dev \
        perl \
# Clean up image
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
