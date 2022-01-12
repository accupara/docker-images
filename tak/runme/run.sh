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

    LOCALDIR=$(readlink -f .)
    REMOTEDIR=/tmp/src
    MNT=$LOCALDIR:$REMOTEDIR
    docker run --rm -it \
        -v $MNT \
        -w $REMOTEDIR/$SUBDIR \
        -e CONAN_USER_HOME=$REMOTEDIR \
        accupara/tak-civ-android:latest \
        $*
}

reset() {
    if [ -e atak-civ ] ; then
        mkdir -p delme .conan
        mv atak-civ .conan delme
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
    elif [ "$1" == "local" ] ; then
        reset

        # Pre-build steps
        docker_cmd atak-civ ./scripts/prebuild.sh

        # Re-gen key
        docker_cmd atak-civ ../keystore_cmds.sh

        # Build!
        docker_cmd atak-civ/atak ./gradlew assembleCivDebug
    elif [ "$1" == "crave" ] ; then
        CRAVE_CONF=$(readlink -f ~/code/crave.foss.crave.io.conf)
        crave -c $CRAVE_CONF run --clean sleep 2
        crave -c $CRAVE_CONF push run.sh -d /data
        crave -c $CRAVE_CONF run /data/run.sh crave_cmds
        crave -c $CRAVE_CONF pull $(crave -c $CRAVE_CONF ssh -- find . -name '*.apk') atak/gradle-build.txt -d .
    elif [ "$1" == "crave_cmds" ] ; then
        allCmds
    else
        echo "Usage:"
        echo "$0 [it|local|crave|crave_cmds]"
    fi
}

allCmds() {
    set -xe
    rm -rf /data/keystore
    mkdir -p /data/keystore
    echo 'export ANDROID_DBG_KEY_FILE=/data/keystore/debug.keystore' >/data/exports.sh
    echo 'export ANDROID_DBG_KEY_ALIAS=androiddebugkey' >>/data/exports.sh
    echo 'export ANDROID_DBG_KEY_PASSWORD=android' >>/data/exports.sh
    echo 'export ANDROID_DBG_STORE_PASSWORD=android' >>/data/exports.sh
    source /data/exports.sh
    keytool -genkeypair -alias ${ANDROID_DBG_KEY_ALIAS} -keypass ${ANDROID_DBG_KEY_PASSWORD} -keystore ${ANDROID_DBG_KEY_FILE} -storepass ${ANDROID_DBG_STORE_PASSWORD} -dname "CN=Android Debug,O=Android,C=US" -validity 9999
    echo "takDebugKeyFile=${ANDROID_DBG_KEY_FILE}" >atak/local.properties
    echo "takDebugKeyFilePassword=${ANDROID_DBG_KEY_PASSWORD}" >>atak/local.properties
    echo "takDebugKeyAlias=${ANDROID_DBG_KEY_ALIAS}" >>atak/local.properties
    echo "takDebugKeyPassword=${ANDROID_DBG_STORE_PASSWORD}" >>atak/local.properties
    echo "takReleaseKeyFile=${ANDROID_DBG_KEY_FILE}" >>atak/local.properties
    echo "takReleaseKeyFilePassword=${ANDROID_DBG_KEY_PASSWORD}" >>atak/local.properties
    echo "takReleaseKeyAlias=${ANDROID_DBG_KEY_ALIAS}" >>atak/local.properties
    echo "takReleaseKeyPassword=${ANDROID_DBG_STORE_PASSWORD}" >>atak/local.properties
    ./scripts/prebuild.sh
    cd atak
    ./gradlew assembleCivDebug assembleCivRelease 2>&1 | tee ./gradle-build.txt
}

main $*
