#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

RELEASETAG=$1
DEVICE=$2
REPONAME=$3
RELEASETITLE=$4

# Check if token.txt exists
if [ ! -f token.txt ]; then
    echo "token.txt doesn't exist!"
    exit 1
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "gh could not be found. Installing gh..."
    curl -sS https://webi.sh/gh | sh
    source ~/.config/envman/PATH.env
    echo "gh installed."
fi

# Authenticate against github.com by reading the token from a file
gh auth login --with-token < token.txt

# Create release	
gh release create $RELEASETAG \
out/target/product/$DEVICE/*.zip \
out/target/product/$DEVICE/recovery.img \
out/target/product/$DEVICE/boot.img \
out/target/product/$DEVICE/vendor_boot.img \
--repo $REPONAME --title $RELEASETITLE --generate-notes
