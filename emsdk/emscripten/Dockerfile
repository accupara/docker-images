# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM emscripten/emsdk

ENV YQ_VER=4.40.3 \
    REPO_NO_INTERACTIVE=1 \
    GIT_TERMINAL_PROMPT=0

RUN set -x \
 #&& sudo dpkg --add-architecture i386 \
 && sudo apt-get update \
 && sudo apt-get -y install \
        binutils \
        build-essential \
        ca-certificates \
        file \
        git \
        python3 \
        python3-pip \
# Add the yq tool from the releases at https://github.com/mikefarah/yq
 && wget -q -O yq https://github.com/mikefarah/yq/releases/download/v${YQ_VER}/yq_linux_amd64 \
 && chmod +x yq \
 && sudo mv yq /usr/bin/ \
# Please stop asking what colors I want
 && git config --global color.ui false \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
