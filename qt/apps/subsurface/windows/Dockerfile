FROM accupara/ubuntu:16.04

RUN buildDeps=' \
      autoconf \
      automake \
      autopoint \
      bash \
      bison \
      bzip2 \
      flex \
      gettext\
      git \
      g++ \
      gperf \
      intltool \
      libffi-dev \
      libgdk-pixbuf2.0-dev \
      libtool-bin \
      libltdl-dev \
      libssl-dev \
      libxml-parser-perl \
      make \
      openssl \
      p7zip-full \
      patch \
      perl \
      pkg-config \
      python \
      ruby \
      scons \
      sed \
      unzip \
      wget \
      xz-utils \
      g++-multilib \
      libc6-dev-i386 \
    ' \
    && sudo apt-get -y update && sudo apt-get install -y --no-install-recommends $buildDeps \
    && sudo rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/admin/src \
    && cd /home/admin/src && git clone https://github.com/mxe/mxe

COPY settings.mk /home/admin/src/mxe
RUN cd /home/admin/src/mxe && make --jobs=18 libxml2 libxslt libusb1 libzip qt5 nsis curl
