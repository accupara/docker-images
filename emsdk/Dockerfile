# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# https://github.com/emscripten-core/emsdk/tags
ENV EMSCRIPTEN_VERSION=3.1.64 \
    EMSDK=/emsdk

RUN set -x \
# install the pre-reqs
 && sudo apt-get update \
 && sudo apt-get install -y \
      python3 \
      python3-pip \
# clone the emsdk sources at the specific location in the environment
 && git clone https://github.com/emscripten-core/emsdk.git emsdk \
 && sudo mv emsdk ${EMSDK} \
# Install using the script
 && cd ${EMSDK} \
 && ./emsdk install ${EMSCRIPTEN_VERSION} \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
