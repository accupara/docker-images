#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

set -x

sudo apt-get install -y \
    python-pycurl

sudo /scratchbox/sbin/sbox_ctl start
sleep 1

wget https://raw.githubusercontent.com/zccrs/build-Qt5-Maemo6/master/harmattan-sdk-setup.py
sed -i 's/show_license = cmd.is_install.*/show_license = False/g' harmattan-sdk-setup.py
chmod +x harmattan-sdk-setup.py

# Fall back to command line interface? ([y]/n) y
echo "y" > /tmp/selection
# Would you like to continue? ([y]/n) y
echo "y" >> /tmp/selection
# Do you accept all the terms of the preceding License Agreement?
#echo "y" >> /tmp/selection
# Would you like to change the selections in the list of users? (y/[n])
echo "n" >> /tmp/selection
# Enter 'go' to begin installation with these settings
echo "go" >> /tmp/selection

cat /tmp/selection | sudo ./harmattan-sdk-setup.py admininstall

echo "alias ll='ls -l'" >> /scratchbox/users/admin/home/admin/.bashrc
echo "alias sb-start='sudo /scratchbox/sbin/sbox_ctl start'" >> ~/.bashrc
echo "alias sb-switch-x86='sb-conf select HARMATTAN_X86'" >> ~/.bashrc
echo "alias sb-switch-armel='sb-conf select HARMATTAN_ARMEL'" >> ~/.bashrc

sudo /scratchbox/sbin/sbox_ctl start
sudo /scratchbox/sbin/sbox_sync

sb-conf select HARMATTAN_X86
/scratchbox/login fakeroot apt-get -y --force-yes install \
    applauncherd-dev \
    libmeegocontrol-dev \
    libmeegotouchevents-dev \
    libmeegotouchhome-dev \
    meegotouch-qt-style-dev

sb-conf select HARMATTAN_ARMEL
/scratchbox/login fakeroot apt-get -y --force-yes install \
    applauncherd-dev \
    libmeegocontrol-dev \
    libmeegotouchevents-dev \
    libmeegotouchhome-dev \
    meegotouch-qt-style-dev

sudo rm -f /tmp/*tgz
