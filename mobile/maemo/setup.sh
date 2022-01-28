#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

set -x

sudo /scratchbox/sbin/sbox_ctl start
sudo /scratchbox/sbin/sbox_sync
sleep 1

wget http://repository.maemo.org/stable/5.0/maemo-sdk-install_5.0.sh
sed -i -e 's/etch/squeeze/g' maemo-sdk-install_5.0.sh
sed -i -e 's/^license$/#license/g' maemo-sdk-install_5.0.sh

sh ./maemo-sdk-install_5.0.sh -d

sudo mkdir -p /scratchbox/users/admin/targets/FREMANTLE_X86/etc/apt/sources.list.d
sudo mkdir -p /scratchbox/users/admin/targets/FREMANTLE_ARMEL/etc/apt/sources.list.d
sudo chown -R admin.admin /scratchbox/users/admin/targets/FREMANTLE_X86 /scratchbox/users/admin/targets/FREMANTLE_ARMEL
cp /tmp/nokia.list /tmp/extras.list /scratchbox/users/admin/targets/FREMANTLE_X86/etc/apt/sources.list.d/
cp /tmp/nokia.list /tmp/extras.list /scratchbox/users/admin/targets/FREMANTLE_ARMEL/etc/apt/sources.list.d/

echo "alias ll='ls -l'" >> /scratchbox/users/admin/home/admin/.bashrc
echo "alias sb-start='sudo /scratchbox/sbin/sbox_ctl start'" >> ~/.bashrc
echo "alias sb-switch-x86='sb-conf select FREMANTLE_X86'" >> ~/.bashrc
echo "alias sb-switch-armel='sb-conf select FREMANTLE_ARMEL'" >> ~/.bashrc

sb-conf se FREMANTLE_X86
/scratchbox/login apt-get update
/scratchbox/login fakeroot apt-get -y --force-yes install \
    nokia-binaries nokia-apps \
    libqt4-dev libqt4-experimental-dev libqtm-dev \
    libtelepathy-qt4-dev \
    cli-common-dev

sb-conf se FREMANTLE_ARMEL
/scratchbox/login apt-get update
/scratchbox/login fakeroot apt-get -y --force-yes install \
    nokia-binaries nokia-apps \
    libqt4-dev libqt4-experimental-dev libqtm-dev \
    libtelepathy-qt4-dev \
    cli-common-dev

# Copy the dh_make files into both targets
cp /tmp/dh_make /scratchbox/users/admin/targets/FREMANTLE_X86/usr/bin/
cp /tmp/dh_make /scratchbox/users/admin/targets/FREMANTLE_ARMEL/usr/bin/

cp -r /tmp/usr_share_debhelper/dh_make /scratchbox/users/admin/targets/FREMANTLE_X86/usr/share/debhelper/
cp -r /tmp/usr_share_debhelper/dh_make /scratchbox/users/admin/targets/FREMANTLE_ARMEL/usr/share/debhelper/

# Cleanup these two files, they are unecessary baggage in this image
rm -f /scratchbox/users/admin/home/admin/maemo-sdk-rootstrap*.tgz
