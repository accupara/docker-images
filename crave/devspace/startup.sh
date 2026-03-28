#!/bin/bash
# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved

set -x

if [ ! -e /home/admin/supervisor/conf.d/vscode.conf ]; then
    cp -f /etc/crave/supervisor/examples/vscode.conf /home/admin/supervisor/conf.d/
fi
if [ ! -e /home/admin/supervisor/conf.d/shellinabox.conf ]; then
    cp -f /etc/crave/supervisor/examples/shellinabox.conf /home/admin/supervisor/conf.d/
fi
sudo service supervisor start
exec $*
