# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/debian:10

#COPY sources.list /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive \
# Copied from: https://github.com/sonic-net/sonic-buildimage/blob/master/sonic-slave-buster/no-check-valid-until
 && echo 'Acquire::Check-Valid-Until "false";' | sudo tee /etc/apt/apt.conf.d/no-check-valid-until \
# Additional entries from https://github.com/sonic-net/sonic-buildimage/blob/a850f8b2f51b96a9d57dab1a6ab55b9ecdeaa0ca/sonic-slave-buster/Dockerfile.j2#L40
 && echo "deb http://ftp.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list \
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
    libtinyxml2-6a \
    libtinyxml2-dev \
    python \
    python-pip \
    python3 \
    python3-pip \
    libncurses5-dev \
    texinfo \
    dh-autoreconf \
    doxygen \
    devscripts \
    git-buildpackage \
    perl-modules \
    libswitch-perl \
    dh-systemd \
    libzmq5 \
    libzmq3-dev \
    uuid-dev \
    jq \
# For sonic-swss-common
	nlohmann-json3-dev \
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
    libpcre2-dev \
    gawk \
    chrpath \
# For frr build
    libc-ares-dev \
    libsnmp-dev \
    libjson-c3 \
    libjson-c-dev \
    libsystemd-dev \
    python-ipaddr \
    libcmocka-dev \
    python3-all-dev \
    python3-all-dbg \
    install-info \
    logrotate \
# For libnl3 (local) build
    cdbs \
# For SAI meta build
    libxml-simple-perl \
    graphviz \
    aspell \
# For SAI meta rpc build - make rpc
    libgetopt-long-descriptive-perl \
    libconst-fast-perl \
    libtemplate-perl \
    libnamespace-autoclean-perl \
    libmoose-perl \
    libmoosex-aliases-perl \
# For linux build
    bc \
    fakeroot \
    build-essential \
    devscripts \
    quilt \
    stgit \
    sbsigntool \
# For platform-modules build
    module-assistant \
# For thrift build\
    gem2deb \
    libevent-dev \
    libglib2.0-dev \
    libqt4-dev \
    python-all-dev \
    python-twisted \
    phpunit \
    libbit-vector-perl \
    openjdk-11-jdk \
    javahelper \
    maven-debian-helper \
    ant \
    libhttpclient-java \
    libslf4j-java \
    libservlet3.1-java \
    qt5-default \
    pkg-php-tools \
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
    ctags \
# For mellanox sai build
    libtool-bin \
    libxml2-dev \
# For BFN sdk build
    libusb-1.0-0-dev \
    libcurl4-openssl-dev \
    libunwind8-dev \
    telnet \
    libc-ares2 \
    libgoogle-perftools4 \
# For build image
    cpio \
    squashfs-tools \
    zip \
# For broadcom sdk build
    linux-compiler-gcc-8-x86 \
    linux-kbuild-4.19 \
# teamd build
    libdaemon-dev \
    libdbus-1-dev \
    libjansson-dev \
# For cavium sdk build
    libpcap-dev \
    dnsutils \
    libusb-dev \
# For cisco sdk build
    libgrpc++1 \
    libabsl-dev \
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
    liblua5.1-0-dev \
    lua-bitop-dev  \
    lua-cjson-dev \
# For mft kernel module build
    dkms \
# For Jenkins static analysis, unit testing and code coverage
    cppcheck \
    clang \
    pylint \
    python-pytest \
    python3-pytest \
    gcovr \
    python-pytest-cov \
    python3-pytest-cov \
    python-parse \
# For snmpd
    default-libmysqlclient-dev \
    libssl-dev \
    libperl-dev \
    libpci-dev \
    libpci3 \
    libsensors5 \
    libsensors4-dev \
    libwrap0-dev \
# For lldpd
	debhelper \
    autotools-dev \
    libbsd-dev \
    pkg-config \
    check \
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
    python-dev \
    libxslt-dev \
# For lockfile
    procmail \
# For gtest
    libgtest-dev \
    cmake \
# For gmock
    libgmock-dev \
# For pam_tacplus build
    autoconf-archive \
# For iproute2
    cm-super-minimal \
    libatm1-dev \
    libelf-dev \
    libmnl-dev \
    libselinux1-dev \
    linuxdoc-tools \
    lynx \
    texlive-latex-extra \
    texlive-latex-recommended \
    iproute2 \
# For bash
    texi2html \
    sharutils \
    locales \
    time \
    man2html-base \
    libcunit1 \
    libcunit1-dev \
# For initramfs
    shellcheck \
    bash-completion \
# For sonic vs image build
    dosfstools \
    qemu-kvm \
    libvirt-clients \
# For ntp
    autogen \
    libopts25-dev \
    pps-tools \
    dh-apparmor \
# For lm-sensors
    librrd8 \
    librrd-dev \
    rrdtool \
# For kdump-tools
    liblzo2-dev \
# For iptables
    libnetfilter-conntrack-dev \
    libnftnl-dev \
# For SAI3.7
    protobuf-compiler \
    libprotobuf-dev \
    xxd \
# For DHCP Monitor tool
    libexplain-dev \
    libevent-dev \
# For libyang
    swig \
# For build dtb
    device-tree-compiler \
# For sonic-mgmt-framework
    autoconf \
    m4 \
    libxml2-utils \
    xsltproc \
    python-lxml \
    libexpat1-dev \
    libcurl4 \
    libcjson-dev \
# For WPA supplication
    qtbase5-dev          \
    aspell-en            \
    libhiredis-dev       \
    swig3.0              \
    libpython2.7-dev     \
    libssl-dev           \
    dbus                 \
    libdbus-1-dev        \
    libdbus-glib-1-2     \
    libdbus-glib-1-dev   \
    libreadline-dev      \
    libncurses5-dev      \
    libpcsclite-dev      \
    docbook-to-man       \
    docbook-utils        \
# For kdump-tools
    libbz2-dev \
# For linkmgrd
    libboost1.71-dev \
    libboost-serialization1.71-dev \
    libboost-program-options1.71-dev \
    libboost-system1.71-dev \
    libboost-thread1.71-dev \
    libboost-atomic1.71-dev \
    libboost-chrono1.71-dev \
    libboost-container1.71-dev \
    libboost-context1.71-dev \
    libboost-contract1.71-dev \
    libboost-coroutine1.71-dev \
    libboost-date-time1.71-dev \
    libboost-fiber1.71-dev \
    libboost-filesystem1.71-dev \
    libboost-graph-parallel1.71-dev \
    libboost-log1.71-dev \
    libboost-regex1.71-dev \
    googletest \
    libgtest-dev \
    libgmock-dev \
    libgcc-8-dev \
# For sonic-host-services build
    libcairo2-dev \
    libdbus-1-dev \
    libgirepository1.0-dev \
    libsystemd-dev \
    pkg-config \
# For sonic-swss-common build
    libhiredis-dev \
# For audisp-tacplus
    libauparse-dev \
    auditd \
# For iproute2
 && sudo eatmydata apt-get install -y -t \
    buster-backports \
    libbpf-dev \
    dwz \
    debhelper
