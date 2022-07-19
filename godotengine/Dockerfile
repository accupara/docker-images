# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04

# Dependencies as mentioned in https://docs.godotengine.org/en/latest/development/compiling/compiling_for_x11.html
RUN sudo apt update &&  \
    sudo DEBIAN_FRONTEND=noninteractive apt install -y \
      build-essential   \
      scons             \
      pkg-config        \
      libx11-dev        \
      libxcursor-dev    \
      libxinerama-dev   \
      libgl1-mesa-dev   \
      libglu-dev        \
      libasound2-dev    \
      libpulse-dev      \
      libudev-dev       \
      libxi-dev         \
      libxrandr-dev     \
      yasm
