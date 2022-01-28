#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

set -x
set -e

FILE=momentics-2.1.2-201503050937.linux.x86_64.run

sudo dpkg --add-architecture i386
sudo apt-get update

sudo apt-get install -y \
    default-jre \
    libbz2-1.0:i386 \
    lib32ncurses5 \
    lib32stdc++6 \
    lib32z1 \
    libwebkitgtk-1.0-0 \
    wget \
    zlib1g:i386

mkdir -p ~/bin/
cd ~/bin/

if [ ! -f /tmp/$FILE ] ; then
    # Download the file ONLY if it doesn't exist
    wget https://developer.blackberry.com/native/downloads/fetch/$FILE
fi

sudo chmod +x /tmp/$FILE
echo y | /tmp/$FILE
sudo rm /tmp/$FILE

xpra control :100 start ~/bin/bbndk/qde

sudo apt-get clean
