#!/bin/bash

follow_build() {
    watch "ps -ef | grep 'docker.\(build\|push\|pull\)' | grep -v runc | grep -v usr.local.lib ; echo '' ; df -h ."
}

push_finished() {
    docker images | grep -v REPO | grep -v quay | \
        awk '{printf("%s:%s\n", $1, $2)}' | \
        while read line ; do
            echo "Pushing image: $line"
            docker push $line && docker rmi $line
        done
    wait
    docker buildx prune -a -f
}

main () {
    if [ "$1" == "follow" ] ; then
        follow_build
    elif [ "$1" == "push_finished" ] ; then
        push_finished
    else
        echo "Usage: $0 [follow|push_finished]"
    fi
}

main $*
