#!/bin/bash
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

# This script is a simplification of https://github.com/crops/yocto-dockerfiles/blob/master/build-install-dumb-init.sh

set -xe

builddir=`mktemp -d`
cd $builddir

if grep -q CentOS /etc/*release; then
    INSTALL_CMD="yum -y install python34-pip glibc-static"
    REMOVE_CMD="yum -y remove python34-pip glibc-static"
elif grep -q Fedora /etc/*release; then
    INSTALL_CMD="dnf -y install glibc-static"
    REMOVE_CMD="dnf -y remove glibc-static"
elif grep -q Ubuntu /etc/*release || grep -q Debian /etc/*release; then
    INSTALL_CMD="apt-get install -y python3-pip"
    REMOVE_CMD="apt-get remove -y python3-pip"
elif grep -q openSUSE /etc/*release; then
    INSTALL_CMD="zypper --non-interactive install python3-pip glibc-devel-static"
    REMOVE_CMD="zypper --non-interactive remove python3-pip glibc-devel-static"
else
    exit 1
fi

wget https://github.com/Yelp/dumb-init/archive/v1.2.0.tar.gz
echo "74486997321bd939cad2ee6af030f481d39751bc9aa0ece84ed55f864e309a3f  v1.2.0.tar.gz" > sha256sums
sha256sum -c sha256sums
tar xf v1.2.0.tar.gz

# Replace the versions of python used for testing dumb-init. Since it is
# testing c code, and not python it shouldn't matter. Also remove the
# pre-commit test from the test rule because we don't care.
sed -i -e 's/envlist = .*/envlist = py3/' dumb-init*/tox.ini
sed -i -e 's/tox -e pre-commit//' dumb-init*/Makefile

$INSTALL_CMD

pip3 install virtualenv

virtualenv $builddir/venv
. $builddir/venv/bin/activate
pip3 install tox

cd dumb-init*
make dumb-init
make test

cp dumb-init /usr/bin/dumb-init
chmod +x /usr/bin/dumb-init

rm $builddir -rf
# Really this should be an exit 1 as well if it fails, but for some reason
# on travis, for fedora it consistently says that it cannot acquire the
# the transaction lock.
$REMOVE_CMD || exit 0
