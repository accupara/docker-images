# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

COPY installqt.qs /tmp/installqt.qs

ENV QT_MAJOR=5.9 \
    QT_VERSION=5.9.1 \
    NDK_VERSION=r14b \
    SDK_VERSION=25.2.3 \
    API_VERSION=16 \
    ANDROID_SDK=android-sdk-linux

ENV QT_BINARIES=qt-opensource-linux-x64-${QT_VERSION}.run \
    SDK_TOOLS=tools_r${SDK_VERSION}-linux.zip \
    ANDROID_NDK=android-ndk-${NDK_VERSION} \
    ANDROID_SDK_ROOT=/opt/${ANDROID_SDK}

ENV QT5_ANDROID=/opt/Qt/${QT_VERSION} \
    NDK_BINARIES=${ANDROID_NDK}-linux-x86_64.zip \
    QT_DOWNLOAD_URL=http://download.qt.io/archive/qt/${QT_MAJOR}/${QT_VERSION}/${QT_BINARIES} \
    SDK_DOWNLOAD_URL=https://dl.google.com/android/repository/${SDK_TOOLS} \
    ANDROID_NDK_ROOT=/opt/${ANDROID_NDK}

ENV NDK_DOWNLOAD_URL=https://dl.google.com/android/repository/${NDK_BINARIES}

RUN sudo apt-get update \
 && sudo apt-get -y --no-install-recommends install \
    git \
    g++ \
    make \
    autoconf \
    automake \
    libtool \
    cmake \
    extra-cmake-modules \
    pkg-config \
    libxml2-dev \
    libxslt1-dev \
    libzip-dev \
    libsqlite3-dev \
    libusb-1.0-0-dev \
    libssl-dev \
    qt5-default \
    qt5-qmake \
    qtchooser \
    qttools5-dev-tools \
    libqt5svg5-dev \
    libqt5webkit5-dev \
    libqt5qml5 \
    libqt5quick5 \
    qtdeclarative5-dev \
    qtscript5-dev \
    libssh2-1-dev \
    libcurl4-openssl-dev \
    qttools5-dev \
    qtconnectivity5-dev \
    qtlocation5-dev \
    qtpositioning5-dev \
    libcrypto++-dev \
    libssl-dev \
    qml-module-qtpositioning \
    qml-module-qtlocation \
    libtool-bin \
    openjdk-8-jdk \
    ant \
    wget \
    unzip \
    xutils-dev \
    python \
 && sudo apt-get clean \
 && wget -q ${QT_DOWNLOAD_URL} \
 && chmod +x ${QT_BINARIES} \
 && sudo ./${QT_BINARIES} --script /tmp/installqt.qs --platform minimal \
 && rm ${QT_BINARIES} \
 && sudo sed -i \
    's/set_property(TARGET Qt5::Core PROPERTY INTERFACE_COMPILE_FEATURES cxx_decltype)/# set_property(TARGET Qt5::Core PROPERTY INTERFACE_COMPILE_FEATURES cxx_decltype)/' \
    /opt/Qt/${QT_VERSION}/android_armv7/lib/cmake/Qt5Core/Qt5CoreConfigExtras.cmake \
 && wget -q ${NDK_DOWNLOAD_URL} \
 && unzip -q ${NDK_BINARIES} \
 && sudo mv ${ANDROID_NDK} /opt/ \
 && rm ${NDK_BINARIES} \
 && wget -q ${SDK_DOWNLOAD_URL} \
 && mkdir -p ${ANDROID_SDK} \
 && cd ${ANDROID_SDK} \
 && unzip -q ../${SDK_TOOLS} \
 && mkdir -p licenses \
 && echo "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "licenses/android-sdk-license" \
 && echo "\nd56f5187479451eabf01fb78af6dfcb131a6481e" > "licenses/android-sdk-license" \
 && echo "\n84831b9409646a918e30573bab4c9c91346d8abd" > "licenses/android-sdk-preview-license" \
 && (while sleep 3; do echo "y"; done) | tools/android update sdk --no-ui --filter tools,platform-tools,build-tools-${SDK_VERSION},android-${API_VERSION} \
 && cd .. \
 && sudo mv ${ANDROID_SDK} /opt/ \
 && rm ${SDK_TOOLS}

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Subsurface for Android" \
      org.label-schema.description="Build environment for compiling Subsurface for Android" \
      org.label-schema.url="https://www.accupara.com/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_REF \
      org.label-schema.vendor="Crave.io Inc."
