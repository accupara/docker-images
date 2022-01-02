#!/bin/bash

docker_win_cmd() {
    SUBDIR=$1
    shift

    MNT="$(cmd.exe /c cd | tr -d '\r' | sed -s 's|\\|\/|g'):C:/code"
    docker.exe run --rm -it \
        --isolation=hyperv \
        -v $MNT \
        -w C:/code/$SUBDIR \
        us.gcr.io/crave-228104/qtbuild:2019 \
        $*
}

docker_cmd() {
    SUBDIR=$1
    shift

    MNT=$(readlink -f .):/tmp/src
    docker run --rm -it \
        -v $MNT \
        -w /tmp/src/$SUBDIR \
        accupara/tak-civ-android:latest \
        $*
}

reset() {
    if [ -e atak-civ ] ; then
        mkdir -p delme
        mv atak-civ delme
        find delme -delete &
    fi

    git clone -b build-system-improvements git@github.com:uvatbc/AndroidTacticalAssaultKit-CIV.git atak-civ
    mkdir -p atak-civ/takengine/thirdparty
    pushd atak-civ/takengine/thirdparty
    git clone git@github.com:synesissoftware/STLSoft-1.9.git stlsoft
    popd
}

it() {
    docker_cmd atak-civ bash
}

main() {
    set -xe

    if [ "$1" == "it" ] ; then
        it
    else
        reset
        docker_cmd atak-civ ./scripts/prebuild.sh
        docker_cmd atak-civ mkdir -p atak/ATAK/app/keystore
        docker_cmd atak-civ/atak/ATAK/app/keystore keytool -genkeypair -alias androiddebugkey -keypass android -keystore debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999
    fi
}

main $*
