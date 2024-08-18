#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

# Find and kill the process associated with the 'repo' command
pids=$(pgrep -f repo)
if [ -n "$pids" ]; then
  echo "Killing repo process with pid(s) $pids"
  kill $pids
fi

# Define an array of directories to check
REPO_DIRS=(/usr/local/bin /usr/bin ~/usr/bin /usr/bin/repo /usr/local/bin/repo /home/admin/bin/repo)

# Define the URL for the new repo file
NEW_REPO_URL="https://raw.githubusercontent.com/accupara/docker-images/master/crave/devspace/common/warning-repo"

# Define the copyright string to check for
COPYRIGHT_STRING="# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved"

for dir in "${REPO_DIRS[@]}"; do
  file="$dir/repo"
  if [ -f "$file" ]; then
    # Check if the file contains the copyright string
    if ! grep -q "$COPYRIGHT_STRING" "$file"; then
      if [[ "$dir" =~ ^/home ]]; then
        curl -o "$file" "$NEW_REPO_URL"
        chmod +x "$file"
        echo "Replaced $file"
      else
        sudo curl -o "$file" "$NEW_REPO_URL"
        sudo chmod +x "$file"
        echo "Replaced $file with sudo"
      fi
    else
      echo "Skipping $file, contains copyright string"
    fi
  fi
done