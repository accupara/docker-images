#!/bin/bash

set -x

rm -rf atak/ATAK/app/keystore
mkdir -p atak/ATAK/app/keystore

echo 'export ANDROID_DBG_KEY_FILE=$(readlink -f atak/ATAK/app/keystore/debug.keystore)' >./scripts/exports.sh
echo 'export ANDROID_DBG_KEY_ALIAS=androiddebugkey' >>./scripts/exports.sh
echo 'export ANDROID_DBG_KEY_PASSWORD=android' >>./scripts/exports.sh
echo 'export ANDROID_DBG_STORE_PASSWORD=android' >>./scripts/exports.sh

source ./scripts/exports.sh

keytool -genkeypair -alias ${ANDROID_DBG_KEY_ALIAS} -keypass ${ANDROID_DBG_KEY_PASSWORD} -keystore ${ANDROID_DBG_KEY_FILE} -storepass ${ANDROID_DBG_STORE_PASSWORD} -dname "CN=Android Debug,O=Android,C=US" -validity 9999

# Generate local properties
cat ../local.properties.template | envsubst | tee ./atak/local.properties
