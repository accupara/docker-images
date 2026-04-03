#!/bin/bash
# Copyright (c) 2016-2026 Crave.io Inc. All rights reserved

#set -x

mkdir -p ~/.local/share/code-server/extensions/
pushd ~/.local/share/code-server/extensions/ 
jq -s 'add | unique_by(.identifier.id)' /opt/crave/code-server/extensions/extensions.json ./extensions.json >./merged_extensions.json
mv ./merged_extensions.json ./extensions.json
for i in $(find /opt/crave/code-server/extensions/ -mindepth 1 -maxdepth 1 -type d) ; do
    ln -sf $i ./
done

popd
