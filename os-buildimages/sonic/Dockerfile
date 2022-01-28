# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/debian:9

COPY sources.list /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive \
# && sudo apt-get update -o Acquire::Check-Valid-Until=false \
 && sudo apt-get update \
 && sudo apt-get install -y debconf-utils \
 && echo "console-setup   console-setup/charmap47 select  ISO-8859-1"                   | sudo debconf-set-selections \
 && echo "keyboard-configuration  keyboard-configuration/variant  select  English (US)" | sudo debconf-set-selections \
 && echo "console-setup   console-setup/codesetcode       string  Lat15"                | sudo debconf-set-selections \
 && echo "console-setup   console-setup/codeset47 select"                               | sudo debconf-set-selections \
 && sudo apt-get dist-upgrade -y \
 && sudo apt-get install -y \
    apt-utils \
    default-jre-headless \
    openssh-server \
    curl \
    wget \
    unzip \
    git \
    build-essential \
    libtool \
    lintian \
    sudo \
    dh-make \
    dh-exec \
    kmod \
    libtinyxml2-4 \
    libboost-program-options1.62-dev \
    libtinyxml2-dev \
    python \
    python-pip \
    libncurses5-dev \
    texinfo \
    dh-autoreconf \
    python3-pip \
    doxygen \
    devscripts \
    git-buildpackage \
    perl-modules \
    libswitch-perl \
    dh-systemd \
# For quagga build
    libreadline-dev \
    texlive-latex-base \
    texlive-generic-recommended \
    texlive-fonts-recommended \
    libpam0g-dev \
    libpam-dev \
    libcap-dev \
    imagemagick \
    ghostscript \
    groff \
    libpcre3-dev \
    gawk \
    chrpath \
# For frr build
    libc-ares-dev \
    libsnmp-dev \
    libjson-c3 \
    libjson-c-dev \
    libsystemd-dev \
    python-ipaddr \
# For libnl3 (local) build
    cdbs \
# For SAI meta build
    libxml-simple-perl \
    graphviz \
    aspell \
# For linux build
    bc \
    fakeroot \
    build-essential \
    devscripts \
    quilt \
    stgit \
# For platform-modules build
    module-assistant \
# For thrift build\
    gem2deb \
    libboost-all-dev \
    libevent-dev \
    libglib2.0-dev \
    libqt4-dev \
    python-all-dev \
    python-twisted \
    phpunit \
    libbit-vector-perl \
    openjdk-8-jdk \
    javahelper \
    maven-debian-helper \
    ant \
    libmaven-ant-tasks-java \
    libhttpclient-java \
    libslf4j-java \
    libservlet3.1-java \
    qt5-default \
# For mellanox sdk build
    libpcre3 \
    libpcre3-dev \
    byacc \
    flex \
    libglib2.0-dev \
    bison \
    expat \
    libexpat1-dev \
    dpatch \
    libdb-dev \
    iptables-dev \
    swig \
# For mellanox sai build
    libtool-bin \
    libxml2-dev \
# For build image
    cpio \
    squashfs-tools \
    zip \
# For broadcom sdk build
    linux-compiler-gcc-6-x86 \
    linux-kbuild-4.9 \
# teamd build
    libdaemon-dev \
    libdbus-1-dev \
    libjansson-dev \
# For cavium sdk build
    libpcap-dev \
    dnsutils \
    libusb-dev \
# For debian image reconfiguration
    augeas-tools \
# For p4 build
    libyaml-dev \
    libevent-dev \
    libjudy-dev \
    libedit-dev \
    libnanomsg-dev \
    python-stdeb \
# For redis build
    libjemalloc-dev \
# For mft kernel module build
    dkms \
# For python3.5 build
    sharutils \
    libncursesw5-dev \
    libbz2-dev \
    liblzma-dev \
    libgdbm-dev \
    tk-dev \
    blt-dev \
    libmpdec-dev \
    libbluetooth-dev \
    locales \
    libsqlite3-dev \
    libgpm2 \
    time \
    net-tools \
    xvfb \
    python-sphinx \
    python3-sphinx \
# For Jenkins static analysis, unit testing and code coverage
    cppcheck \
    clang \
    pylint \
    python-pytest \
    gcovr \
    python-pytest-cov \
    python-parse \
# For snmpd
    default-libmysqlclient-dev \
    libssl1.0-dev \
    libperl-dev \
    libpci-dev \
    libpci3 \
    libsensors4 \
    libsensors4-dev \
    libwrap0-dev \
# For mpdecimal
    docutils-common \
    libjs-sphinxdoc \
    libjs-underscore \
    python-docutils \
    python-jinja2 \
    python-markupsafe \
    python-pygments \
    python-roman \
    python-sphinx \
    sphinx-common \
    python3-sphinx \
# For sonic config engine testing
    python-lxml \
    python-jinja2 \
    python-netaddr \
    python-ipaddr \
    python-yaml \
    python3-yaml \
# For lockfile
    procmail \
# For gtest
    libgtest-dev \
    cmake \
# For pam_tacplus build
    autoconf-archive \
# For python-click build
    python-sphinx \
    python-docutils \
    python3-all \
    python3-setuptools \
    python3-sphinx \
    python3-docutils \
    python3-requests \
    python3-pytest \
    python3-colorama \
# For initramfs
    bash-completion \
# For linux build
 && sudo apt-get -y build-dep linux \
# BASH dependencies
 && sudo apt-get install -y texi2html \
# For gobgp and telemetry build
 && export VERSION=1.11.5 \
 && cd /tmp/ \
 && wget -q https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz \
 && sudo tar -C /usr/local -xzf go$VERSION.linux-amd64.tar.gz \
 && echo 'export GOROOT=/usr/local/go'   | sudo tee -a /etc/bash.bashrc \
 && echo 'export PATH=$PATH:$GOROOT/bin' | sudo tee -a /etc/bash.bashrc \
# Upgrade pip2
# Note: use pip2 specific version so jinja2 2.10 will install
 && sudo python2 -m pip install -U pip==9.0.3 \
# For p4 build
 && sudo pip install \
    ctypesgen \
    crc16 \
# For sonic config engine testing
    pyangbind==0.6.0 \
# Note: force upgrade debian packaged jinja2, if installed
 && sudo pip install --force-reinstall --upgrade jinja2>=2.10 \
# For templating (requiring jinja2)
 && sudo pip install j2cli \
# For sonic utilities testing
    click-default-group click natsort tabulate netifaces==0.10.7 fastentrypoints \
# For supervisor build
    meld3 mock \
# Install dependencies for isc-dhcp-relay build
 && sudo apt-get -y build-dep isc-dhcp \
# Install docker-ce
 && sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
# Needed to install Debian/Debhelper/Sequence/phpcomposer.pm
 && sudo apt-get install -y pkg-php-tools \
# Install new docker
 && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
 && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
# && sudo apt-get update -o Acquire::Check-Valid-Until=false \
 && sudo apt-get update \
 && sudo apt-get -y install -y docker-ce-cli \
 && sudo mv /usr/bin/docker /usr/bin/docker-bin \
 && echo "#!/bin/bash" | sudo tee -a /usr/bin/docker \
 && echo "sudo /usr/bin/docker-bin $*" | sudo tee -a /usr/bin/docker \
 && sudo chmod +x /usr/bin/docker \
# Added dependencies based on compilation failures
 && sudo apt-get install -y \
    automake1.11 \
    check \
    debhelper \
    librrd-dev \
    libselinux1-dev \
# Clean up
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_* \
 && cd /usr/src/gtest && sudo cmake . && sudo make \
 && sudo git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /usr/share/depot_tools
