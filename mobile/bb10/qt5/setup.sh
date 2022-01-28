#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

IMGNAME=accupara/bb10_qt5
BUILD_CONTAINER=bb10_qt5

function compile_bb10_qt53() {
    # Make the output directory if it hasn't been created already
    mkdir -p $1

    make distclean || true

    # Configure qt 5.3 for armle
    export PREFIX=$(readlink -f $1)
    export XPLATFORM=$2
    ./configure \
        -prefix ${PREFIX} \
        -xplatform ${XPLATFORM} \
        -opengl es2 \
        -nomake examples \
        -nomake tests \
        -opensource \
        -confirm-license \
        -release

    # Make and make install
    make
    make install
}

function run_inside() {
    set -x
    set -e

    # Install the pre-requisites
    sudo apt-get install -y \
        bison \
        flex \
        gperf \
        libicu-dev \
        libqt4-dev-bin \
        libxslt-dev \
        ruby

    # Make a place for the code
    mkdir -p /tmp/src
    cd /tmp/src

    # Pull the code: qt 5.3: This is the latest version of qt5 that actually works
    git clone git://code.qt.io/qt/qt5.git
    cd qt5
    git checkout v5.3.0
    perl init-repository -f \
        -no-webkit \
        -module-subset=qtbase,qtxmlpatterns,qtdeclarative,qtsensors,qtmultimedia,qtgraphicaleffects,qtconnectivity,qtquickcontrols,qtlocation
    #git submodule update

    # Compile for arm v7
    compile_bb10_qt53 ~/bin/qt5/armle blackberry-armle-v7-qcc
    # Compile for x86
    compile_bb10_qt53 ~/bin/qt5/x86   blackberry-x86-qcc

    rm -rf /tmp/src
}

function run_outside() {
    set -x
    set -e

    SCRIPTPATH=$(readlink -f $0)

    docker pull accupara/bbndk

    docker run \
        -it \
        --name $BUILD_CONTAINER \
        -v $SCRIPTPATH:/tmp/setup.sh \
        accupara/bbndk \
        /tmp/setup.sh inside

    # Create two images: one for arm, one for x86
    docker commit \
        --change 'ENV PATH /home/admin/bin/qt5/armle/bin:/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/bin:/home/admin/.rim/bbndk/bin:/home/admin/bin/bbndk/features/com.qnx.tools.jre.linux.x86_64_1.7.0.51/jre/bin:/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/python32/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' \
        $BUILD_CONTAINER \
        $IMGNAME:arm

    docker commit \
        --change 'ENV PATH /home/admin/bin/qt5/x86/bin:/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/bin:/home/admin/.rim/bbndk/bin:/home/admin/bin/bbndk/features/com.qnx.tools.jre.linux.x86_64_1.7.0.51/jre/bin:/home/admin/bin/bbndk/host_10_3_1_12/linux/x86/usr/python32/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' \
        $BUILD_CONTAINER \
        $IMGNAME:x86

    # Push them both
    docker push $IMGNAME:arm
    docker push $IMGNAME:x86

    # Cleanup all Exited containers
    docker ps -a | grep Exited | awk '{print $1}' | while read line ; do docker rm $line ; done
}

function run_help() {
    echo "Run this script ($0) without any arguments to create a BB10 container with qt5 compiled and usable in it"
}

function run_it() {
    set -x
    set -e

    SCRIPTPATH=$(readlink -f $0)

    docker run \
        --rm -it \
        -name $BUILD_CONTAINER \
        -v $SCRIPTPATH:/tmp/setup.sh \
        -v /mnt/src-20170212:/tmp/src \
        accupara/bbndk \
        /bin/bash
}

function main() {
    if [ "$1" == "inside" ] ; then
        run_inside $*
    elif [ "$1" == "help" ] ; then
        run_help $*
    elif [ "$1" == "it" ] ; then
        run_it $*
    elif [ "$1" == "source" ] ; then
        echo "Script sourced"
    else
        run_outside $*
    fi
}

main $*
