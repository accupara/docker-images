# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

RUN sudo apt-get update \
 && sudo apt-get install -y \
        bison \
        build-essential \
        flex \
        gettext \
        libgettextpo0 \
        libkrb5-dev \
        libossp-uuid-dev \
        libpam0g-dev \
        libperl-dev \
        libreadline6-dev \
        libssl-dev \
        libtcl8.6 \
        libxml2-dev \
        libxslt1-dev \
        perl-modules \
        python \
        python-dev \
        python3-dev \
        python3 \
        readline-common \
        tcl \
        tcl-dev \
        zlib1g-dev \
        libxml2-utils \
        xsltproc \
 && sudo apt-get clean

# Timescale DB packages
RUN sudo apt-get install -y \
       cmake \
       clang-format-7 \
       postgresql \
       postgresql-client \
       postgresql-common \
       postgresql-client-common \
       postgresql-server-dev-all \
 # clang-format-7 does not create link to clang-format and that causes failure in bootstrap script of timescaledb
 && sudo ln -s /usr/bin/clang-format-7 /usr/bin/clang-format \
 && sudo apt-get clean
 
