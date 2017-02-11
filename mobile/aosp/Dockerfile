# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Accupara Inc. "contact@accupara.com"

# Follow the install requirements from https://source.android.com/source/initializing.html
RUN sudo apt-get update && \
    sudo apt-get install -y \
     bison \
     build-essential \
     ccache \
     curl \
     flex \
     git-core \
     gnupg \
     gperf \
     gcc-multilib \
     g++-multilib \
     lib32ncurses5-dev \
     lib32z-dev \
     libc6-dev-i386 \
     libgl1-mesa-dev \
     libx11-dev \
     libxml2-utils \
     openjdk-8-jdk \
     xsltproc \
     unzip \
     x11proto-core-dev \
     zip \
     zlib1g-dev

# Add repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /tmp/repo && \
    chmod +x /tmp/repo && \
    sudo mv /tmp/repo /usr/bin/ && \
    repo init || exit 0
