FROM accupara/lkbuild:latest

RUN set -x \
 && sudo eatmydata apt-get update \
 && sudo eatmydata apt-get install -y \
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
&& sudo eatmydata apt-get clean \
&& sudo rm -rf /var/lib/apt/lists/*
