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
        -e CONAN_USER_HOME=$MNT \
        accupara/tak-civ-android:latest \
        $*
}

reset() {
    if [ -e atak-civ ] ; then
        mkdir -p delme
        mv atak-civ delme
        find delme -delete &
    fi

    git clone --recurse-submodules -j 2 -b build-system-improvements git@github.com:uvatbc/AndroidTacticalAssaultKit-CIV.git atak-civ
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

        # Pre-build steps
        docker_cmd atak-civ ./scripts/prebuild.sh

        # Re-gen key
        docker_cmd atak-civ ../keystore_cmds.sh

        # Build!
        docker_cmd atak-civ/atak ./gradlew assembleCivDebug
    fi
}

main $*
