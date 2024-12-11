# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

# https://github.com/emscripten-core/emsdk/tags
ENV EMSCRIPTEN_VERSION=3.1.64 \
    CMAKE_VER=3.27.9 \
    EMSDK=/emsdk

RUN set -x \
# install the pre-reqs
 && sudo apt-get update \
 && sudo apt-get install -y \
      ca-certificates \
      libxml2 \
      libidn12 \
      openjdk-11-jre-headless \
      python3 \
      python3-pip \
# Latest version of cmake required for compilation
 && ARCH=$(uname -m) \
 && wget -q -O /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-Linux-$ARCH.sh \
 && chmod +x /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh \
 && sudo /tmp/cmake-${CMAKE_VER}-Linux-$ARCH.sh --skip-license --prefix=/usr \
# clone the emsdk sources at the specific location in the environment
 && git clone https://github.com/emscripten-core/emsdk.git emsdk \
 && sudo mv emsdk ${EMSDK} \
# Install using the script
 && cd ${EMSDK} \
 && ./emsdk install ${EMSCRIPTEN_VERSION} \
# Other install steps from https://github.com/emscripten-core/emsdk/blob/main/docker/Dockerfile
# This generates configuration that contains all valid paths according to installed SDK
 && echo "## Generate standard configuration" \
 && ./emsdk activate ${EMSCRIPTEN_VERSION} \
 && chmod 777 ${EMSDK}/upstream/emscripten \
 && chmod -R 777 ${EMSDK}/upstream/emscripten/cache \
 && echo "int main() { return 0; }" > hello.c \
 && ${EMSDK}/upstream/emscripten/emcc -c hello.c \
 && cat ${EMSDK}/upstream/emscripten/cache/sanity.txt \
 && echo "## Done" \
# Cleanup Emscripten installation and strip some symbols
 && echo "## Aggressive optimization: Remove debug symbols" \
 && cd ${EMSDK} && . ./emsdk_env.sh \
# Remove debugging symbols from embedded node (extra 7MB)
 && strip -s `which node` \
# Tests consume ~80MB disc space
 && rm -fr ${EMSDK}/upstream/emscripten/tests \
# strip out symbols from clang (~extra 50MB disc space)
 && find ${EMSDK}/upstream/bin -type f -exec strip -s {} + || true \
 && echo "## Done" \
# Final cleanups
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
