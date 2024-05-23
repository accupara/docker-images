#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

DEVICE=$1
EXTRAFILES=$2
IMG_FILES=""
ZIP_FILES=""

# Check if Credentials exists
if [ ! -f ~/.config/telegram-upload.json ]; then
    echo "~/.config/telegram-upload.json doesn't exist!"
    exit 1
fi
if [ ! -f ~/.config/telegram-upload.session ]; then
    echo "~/.config/telegram-upload.session doesn't exist!"
    exit 1
fi

# Set Upload Limit if not already set
: ${TG_UPLOAD_LIMIT:=2147483648}
echo "Upload Limit is set to $TG_UPLOAD_LIMIT"

# Check if telegram-upload is installed
if ! command -v telegram-upload &> /dev/null; then
    echo "telegram-upload could not be found. Installing it..."
    sudo python3 -m pip install -U telegram-upload
    echo "telegram-upload installed."
fi

# Scan Release IMG_FILES
for img_file in out/target/product/$DEVICE/*.img; do
    if [[ -n $img_file && $(stat -c%s "$img_file") -le $TG_UPLOAD_LIMIT ]]; then # Try to match github releases per size limit
        IMG_FILES+="$img_file "
        echo "Selecting $img_file for Upload"
    else
        echo "Skipping $img_file"
    fi
done
echo "Image Files to be uploaded: $IMG_FILES"

if [ -n "$(find out/target/product/$DEVICE/ -maxdepth 1 -name "*.zip")" ]; then
# Now do the same for ZIP_FILES
for zip_file in out/target/product/$DEVICE/*.zip; do
    if [[ -n $zip_file && $(stat -c%s "$zip_file") -le $TG_UPLOAD_LIMIT ]]; then # Try to match github releases per size limit
        ZIP_FILES+="$zip_file "
        echo "Selecting $zip_file for Upload"
    else
        echo "Skipping $zip_file"
    fi
done
else
    echo "No zip files found in out/target/product/$DEVICE/"
fi

echo "Zip Files to be uploaded: $ZIP_FILES"
echo "Extra Files to be uploaded: $EXTRAFILES"

# Create release	
if [ "${DCDEVSPACE}" == "1" ]; then
    crave push ~/.config/telegram-upload.json -d /home/admin/.config/telegram-upload.json
    crave push ~/.config/telegram-upload.session -d /home/admin/.config/telegram-upload.session
    crave ssh -- "export TG_UPLOAD_LIMIT="$TG_UPLOAD_LIMIT"; bash /opt/crave/telegram/upload.sh "$DEVICE" "$EXTRAFILES""
else
    telegram-upload $ZIP_FILES $IMG_FILES $EXTRAFILES
fi
