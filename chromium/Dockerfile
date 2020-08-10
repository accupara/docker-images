# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:18.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# https://chromium.googlesource.com/chromium/src/+/master/docs/linux_suid_sandbox_development.md

ENV SRC="/src" LC_CTYPE="en_US.UTF-8" CHROME_DEVEL_SANDBOX="1"

# RUN sudo useradd -m chromium \
RUN sudo mkdir $SRC \
 && sudo chown -R admin:admin $SRC \
 && perl -pi -e 's/archive.ubuntu.com/us.archive.ubuntu.com/' /etc/apt/sources.list \
 && echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse"              | sudo tee --append /etc/apt/sources.list \
 && echo "deb-src http://us.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse"          | sudo tee --append /etc/apt/sources.list \
 && echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse"      | sudo tee --append /etc/apt/sources.list \
 && echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse"     | sudo tee --append /etc/apt/sources.list \
 && echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse"    | sudo tee --append /etc/apt/sources.list \
 && echo "deb-src http://us.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse"  | sudo tee --append /etc/apt/sources.list \
 && sudo apt-get update \
 && sudo apt-get -yq install locales \
 && sudo locale-gen "en_US.UTF-8" \
 && sudo dpkg-reconfigure locales \
 && sudo apt-get -yq install \
    aptitude \
    build-essential \
    bzip2 \
    dpkg \
    git \
    pkg-config \
    software-properties-common \
    unzip \
 && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections \
 && echo tzdata tzdata/Zones/Etc UTC | sudo tee debconf-set-selections \
 && echo Etc/UTC | sudo tee /etc/timezone \
 && echo tzdata tzdata/Areas select Etc | sudo tee debconf-set-selections \
 && sudo apt-get install ttf-mscorefonts-installer -yq \
 && sudo apt-get install -yq \
    ant \
    apache2 \
    autoconf \
    bison \
    cdbs \
    cmake \
    curl \
    devscripts \
    dpkg-dev \
    elfutils \
    fakeroot \
    ffmpeg \
    flex \
    fonts-indic \
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
    libasound2 \
    libasound2-dev \
    libatk1.0-0 \
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
    manpages-pl \
    manpages-fr-extra \
    mesa-common-dev \
    openbox \
    patch \
    perl \
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
    rpm \
    ruby \
    subversion \
    texinfo \
    ttf-dejavu-core \
    ttf-mscorefonts-installer \
    wdiff \
    xsltproc \
    xutils-dev \
    xvfb \
    zip \
    zlib1g \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

RUN \
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y

RUN \
    cd /opt \
    && sudo git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

ENV PATH=/opt/depot_tools:$PATH

RUN \
    curl -s https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT | base64 -d \
    | perl -pe 's/  if \[ -z "\$new_list.*/  if false; then/' \
    | perl -pe 's/apt-get install \$\{do_quietly-}.*/DEBIAN_FRONTEND=noninteractive apt-get install -y \$packages/' \
    | bash -e -s - \
        --no-syms \
        --no-arm \
        --no-chromeos-fonts \
        --no-nacl \
        --no-prompt \
        --unsupported

RUN \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
