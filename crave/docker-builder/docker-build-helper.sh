#!/bin/bash

follow_build() {
    watch "ps -ef | grep 'docker.\(build\|push\|pull\)' | grep -v runc | grep -v usr.local.lib"
}

main () {
    if [ "$1" == "follow" ] ; then
        follow_build
    else
        echo "Usage: $0 [follow]"
    fi
}

main $*