#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

set -x
set -e

echo "DISPLAY=:100" >> ~/.bashrc
export DISPLAY=:100

sudo mkdir -p /var/run/sshd
sudo /usr/sbin/sshd

rm -f /tmp/.X100-lock
xpra start $DISPLAY

sleep 1

cp ~/.xpra/run-xpra /tmp/run-xpra
cat /tmp/run-xpra | grep -v affinity > ~/.xpra/run-xpra

sleep infinity

