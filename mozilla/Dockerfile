# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
# From the deps specified at https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites
FROM accupara/ubuntu:17.10
MAINTAINER Accupara Inc. "contact@accupara.com"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install -y  \
    autoconf2.13        \
    binutils-avr        \
    build-essential     \
    cargo               \
    fontconfig          \
    git                 \
    libasound2-dev      \
    libdbus-glib-1-dev  \
    libfreetype6        \
    libgconf2-dev       \
    libgl1-mesa-dev     \
    libgstreamer1.0-dev \
    libgtk2.0-dev       \
    libgtk-3-dev        \
    libidl-dev          \
    libnotify-dev       \
    libpulse-dev        \
    libxt-dev           \
    mercurial           \
    perl                \
    pkg-config          \
    python2.7           \
    rustc               \
    wget                \
    yasm                \
    zip                 \
 && sudo rm -rf /var/lib/apt/lists/*

 ENV SHELL=/bin/bash
