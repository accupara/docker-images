#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

SRC_MOUNT=/go/src/vitess.io/vitess

if [ -d $SRC_MOUNT ] ; then
    pushd $SRC_MOUNT
    make -C $SRC_MOUNT prep_for_docker
    source dev.env
    popd
fi

#set -x

# Uncomment this to debug what is going on
#echo "Running command: \"$@\""

exec $@
