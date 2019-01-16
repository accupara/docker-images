# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

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
     software-properties-common \
     xsltproc \
     unzip \
     wget \
     x11proto-core-dev \
     zip \
     zlib1g-dev

# Add repo
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /tmp/repo && \
    chmod +x /tmp/repo && \
    sudo mv /tmp/repo /usr/bin/ && \
    repo init || exit 0

# Set up default git user
RUN git config --global user.name "Default user" && \
    git config --global user.email "default@example.com"

# Older versions of AOSP need some combination of this instead of openjdk-8-jdk:
#RUN sudo add-apt-repository -y ppa:webupd8team/java && \
#    sudo apt-get update && \
#    sudo apt-get install -y oracle-java6-installer

# Compile and use make 3.81
#RUN cd /tmp/ ; wget https://ftp.gnu.org/gnu/make/make-3.81.tar.bz2 && \
#    tar -xf make-3.81.tar.bz2 && \
#    cd make-3.81 && \
#    ./configure --without-guile && \
#    make && sudo make install && \
#    cd /tmp && rm -rf make-3.81*
