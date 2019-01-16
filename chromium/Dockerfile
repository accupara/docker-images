# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:14.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# https://chromium.googlesource.com/chromium/src/+/master/docs/linux_suid_sandbox_development.md

ENV SRC="/src" LC_CTYPE="en_US.UTF-8" CHROME_DEVEL_SANDBOX="1"

# RUN sudo useradd -m chromium \
RUN sudo mkdir $SRC \
 && sudo chown -R admin:admin $SRC \
 && echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse"              | sudo tee --append /etc/apt/sources.list \
 && echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse"          | sudo tee --append /etc/apt/sources.list \
 && echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"      | sudo tee --append /etc/apt/sources.list \
 && echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse"  | sudo tee --append /etc/apt/sources.list \
 && sudo locale-gen "en_US.UTF-8" \
 && sudo dpkg-reconfigure locales \
 && sudo apt-get update \
 && sudo apt-get -yq install \
    aptitude \
    build-essential \
    bzip2 \
    dpkg \
    git \
    pkg-config \
    python-software-properties \
    software-properties-common \
    unzip \
 && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections \
 && sudo apt-get install ttf-mscorefonts-installer -yq \
 && sudo apt-get install -yq \
    ant \
    apache2.2-bin \
    autoconf \
    bison \
    cdbs \
    cmake \
    curl \
    devscripts \
    dpkg-dev \
    elfutils \
    fakeroot \
    flex \
    fonts-thai-tlwg \
    g++ \
    g++-mingw-w64-i686 \
    gawk \
    git-core \
    git-svn \
    gperf \
    intltool \
    language-pack-da \
    language-pack-fr \
    language-pack-he \
    language-pack-zh-hant \
    lib32gcc1 \
    lib32ncurses5-dev \
    lib32stdc++6 \
    lib32z1-dev \
    libapache2-mod-php5 \
    libasound2 \
    libasound2-dev \
    libatk1.0-0 \
    libav-tools \
    libbluetooth-dev \
    libbrlapi-dev \
    libbrlapi0.6 \
    libbz2-1.0 \
    libbz2-dev \
    libc6 \
    libc6-i386 \
    libcairo2 \
    libcairo2-dev \
    libcap-dev \
    libcap2 \
    libcups2 \
    libcups2-dev \
    libcurl4-gnutls-dev \
    libdrm-dev \
    libelf-dev \
    libexif-dev \
    libexif12 \
    libexpat1 \
    libffi-dev \
    libffi6 \
    libfontconfig1 \
    libfreetype6 \
    libgbm-dev \
    libgconf-2-4 \
    libgconf2-dev \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libgles2-mesa-dev \
    libglib2.0-0 \
    libglib2.0-dev \
    libglu1-mesa-dev \
    libgnome-keyring-dev \
    libgnome-keyring0 \
    libgpm2 \
    libgtk2.0-0 \
    libgtk2.0-dev \
    libjpeg-dev \
    libkrb5-dev \
    libncurses5 \
    libnspr4 \
    libnspr4-dev \
    libnss3 \
    libnss3-dev \
    libpam0g \
    libpam0g-dev \
    libpango1.0-0 \
    libpci-dev \
    libpci3 \
    libpcre3 \
    libpixman-1-0 \
    libpng12-0 \
    libpulse-dev \
    libpulse0 \
    libsctp-dev \
    libspeechd-dev \
    libspeechd2 \
    libsqlite3-0 \
    libsqlite3-dev \
    libssl1.0.0 \
    libssl-dev \
    libstdc++6 \
    libtinfo-dev \
    libtool \
    libudev-dev \
    libudev1 \
    libwww-perl \
    libx11-6 \
    libxau6 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxdmcp6 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxinerama1 \
    libxkbcommon-dev \
    libxrandr2 \
    libxrender1 \
    libxslt1-dev \
    libxss1 \
    libxss-dev \
    libxt-dev \
    libxtst-dev \
    libxtst6 \
    mesa-common-dev \
    openbox \
    patch \
    perl \
    php5-cgi \
    pkg-config \
    python \
    python-cherrypy3 \
    python-crypto \
    python-dev \
    python-numpy \
    python-opencv \
    python-openssl \
    python-psutil \
    python-yaml \
    realpath \
    rpm \
    ruby \
    subversion \
    texinfo \
    ttf-dejavu-core \
    ttf-indic-fonts \
    ttf-kochi-gothic \
    ttf-kochi-mincho \
    ttf-mscorefonts-installer \
    wdiff \
    xfonts-mathml \
    xsltproc \
    xutils-dev \
    xvfb \
    zip \
    zlib1g \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*
