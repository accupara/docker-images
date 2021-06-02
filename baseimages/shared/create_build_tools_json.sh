#!/bin/bash
# Copyright (c) 2016-2020 Crave.io Inc. All rights reserved

usage() {
    echo "Usage:"
    echo "$0 </path/to/toolchain>"
}

append_list() {
    find $TOOLCHAIN_DIR -type f -name "$1" | \
        xargs file | grep 'ELF.*executable.*x86' | \
        cut -d: -f1 | \
    while read line ; do
        readlink -f $line
    done | \
    sort -u >>/tmp/list.txt
}

append_pie_list() {
    find $TOOLCHAIN_DIR -type f -name "$1" | \
        xargs file | grep 'ELF.*x86' | \
        cut -d: -f1 | \
    while read line ; do
        line=$(readlink -f $line)
        if [ $(hardening-check $line | grep -c 'Position.*yes') == "1" ] ; then
            # This is a valid PIE binary
            echo $line
        fi
    done | \
    sort -u >>/tmp/list.txt
}

make_list() {
    rm /tmp/list.txt

    # If there is no input, jq errors out and no output is created
    # If there is an existing build_tools.conf, it is converted into a flat list
    jq -r '.[]' </etc/crave/build_tools.conf >/tmp/list.txt
}

make_json() {
    # Opening square bracket
    echo "[" >/tmp/op.txt

    # Sort, remove duplicates, surround with qoutes and append a comma at the end
    sort -u /tmp/list.txt | \
    while read line ; do
        echo "\"$line\"," >>/tmp/op.txt
    done

    # Remove the comma on the last line
    sed '$s/,$//' </tmp/op.txt >/tmp/op1.txt

    # Closing square bracket
    echo "]" >>/tmp/op1.txt
    mv /tmp/op1.txt /tmp/op.txt

    # Fail the script if jq doesn't like this data
    set -e
    cat /tmp/op.txt | jq .
    set +e

    # Move into build_tools.conf
    sudo mkdir -p /etc/crave/
    sudo mv /tmp/op.txt /etc/crave/build_tools.conf
}

main() {
    TOOLCHAIN_DIR=$1
    if [ "$TOOLCHAIN_DIR" == "" ] ; then
        echo "You must provide the path to the toolchain."
        usage
        exit 1
    fi

    echo "| Parsing the existing build tools conf file..."
    make_list

    echo "| Looking through $TOOLCHAIN_DIR for gcc..."
    append_list '*-gcc'
    echo "| Looking through $TOOLCHAIN_DIR for g++..."
    append_list '*-g++'
    echo "| Looking through $TOOLCHAIN_DIR for cpp..."
    append_list '*-cpp'

    echo "| Looking through $TOOLCHAIN_DIR for rustc..."
    append_pie_list 'rustc'

    echo "| Converting the list of $(wc -l /tmp/list.txt | awk '{print $1}') compilers in /tmp/list.txt into a build_tools.conf ..."
    make_json
}

main $*
