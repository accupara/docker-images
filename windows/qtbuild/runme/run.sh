#!/bin/bash

docker_cmd() {
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

reset() {
    mkdir -p delme
    mv qt6-build qt5 qt6 delme/
    find delme -delete &

    mkdir qt6-build qt6
    git clone https://code.qt.io/qt/qt5.git qt5
    cd qt5
    git checkout 6.2.1
    cd ..

    docker_cmd qt5 powershell.exe /c perl .\\init-repository
}

main() {
    set -xe

    reset
    docker_cmd qt6-build powershell.exe /c ..\\qt5\\configure -prefix C:\\code\\qt6
    #docker_cmd qt6-build powershell.exe /c cmake --build . --parallel
    docker_cmd qt6-build powershell.exe /c cmake --build .
}

main $*
