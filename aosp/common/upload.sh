#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

RELEASETAG=$1
DEVICE=$2
REPONAME=$3
RELEASETITLE=$4
FILES=""

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

# Scan Release Files
for file in out/target/product/$DEVICE/*.img; do
    if [[ -n $file && $(stat -c%s "$file") -le 2147483648 ]]; then
    FILES+="$file "
    echo "Adding $file to FILES"
  else
    echo "Skipping $file"
    continue
  fi
done
echo "Uploaded files: $FILES"

# Create release	
gh release create $RELEASETAG out/target/product/$DEVICE/*.zip \
                             out/target/product/$DEVICE/$FILES \
--repo $REPONAME --title $RELEASETITLE --generate-notes
