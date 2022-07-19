FROM accupara/lkbuild:latest
LABEL org.opencontainers.image.author.name="Crave.io Inc." \
      org.opencontainers.image.author.name="contact@crave.io"

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get install -y \
      autoconf \
      automake \
      build-essential \
      cmake \
      cppcheck \
      clang-3.6 \
      curl \
      g++ \
      libboost-all-dev \
      libc++-dev \
      libgflags-dev \
      libgtest-dev \
      libprotobuf-dev \
      libtool \
      make \
      ninja-build \
      protobuf-compiler \
      python3 \
      python3-pip \
      pkg-config \
      unzip \
&& sudo apt-get clean \
&& sudo rm -rf /var/lib/apt/lists/*
