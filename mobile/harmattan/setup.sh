#!/bin/bash
# Copyright (c) 2016 Accupara Inc. All rights reserved

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
