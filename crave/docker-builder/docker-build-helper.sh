#!/bin/bash

follow_build() {
    watch "ps -ef | grep 'docker.\(build\|push\|pull\)' | grep -v runc | grep -v usr.local.lib ; echo '' ; df -h ."
}

main () {
    if [ "$1" == "follow" ] ; then
        follow_build
    else
        echo "Usage: $0 [follow]"
    fi
}

main $*
