#!/bin/bash

set -x
echo "Contents of src:"
ls -la /src

if [ -e /src/find_ams_service_envs.sh ]; then
	/src/find_ams_service_envs.sh
fi
#exec $*
