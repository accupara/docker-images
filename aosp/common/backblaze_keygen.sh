#!/bin/bash
set -euo pipefail

# Making sure the script is run on Devspace CLI
if [ "${DCDEVSPACE:-0}" == "1" ]; then

    # Variables
    SUBJECT='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'
    CERT_DIR=$(mktemp -d /tmp/android-certs.XXXXXX)

    # Function to cleanup sensitive data
    cleanup() {
        echo "Cleaning up..."
        rm -rf "$CERT_DIR"
        echo "Cleared Certificates from Devspace"

        echo "Clearing ENV Variables"
        unset BUCKET_NAME
        unset BKEY_ID
        unset BAPP_KEY
        unset PASS_ENCRYPT
        unset PASSWORD
        echo "Cleared ENV Variables"
    }
    trap cleanup EXIT
    
    read -sp "Enter the password: " PASSWORD
    echo
    read -sp "Enter the Encryption Password: " PASS_ENCRYPT
    echo

    # Restrict file permissions
    umask 077

    # Create certificate directory
    mkdir -p "$CERT_DIR"

    # Encrypt password
    echo "$PASSWORD" | openssl enc -aes-256-cbc -iter 256 -salt -out "$CERT_DIR/password.enc" -pass pass:"$PASS_ENCRYPT"

    # Generate keys with passwords
    for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do
        ./development/tools/make_key "$CERT_DIR/$cert" "$SUBJECT" -password pass:"$PASSWORD"
    done

    # Generate APEX keys with passwords
    for apex in com.android.adbd com.android.adservices com.android.adservices.api com.android.appsearch com.android.art com.android.bluetooth com.android.btservices com.android.cellbroadcast com.android.compos com.android.configinfrastructure com.android.connectivity.resources com.android.conscrypt com.android.devicelock com.android.extservices com.android.graphics.pdf com.android.hardware.biometrics.face.virtual com.android.hardware.biometrics.fingerprint.virtual com.android.hardware.boot com.android.hardware.cas com.android.hardware.wifi com.android.healthfitness com.android.hotspot2.osulogin com.android.i18n com.android.ipsec com.android.media com.android.media.swcodec com.android.mediaprovider com.android.nearby.halfsheet com.android.networkstack.tethering com.android.neuralnetworks com.android.ondevicepersonalization com.android.os.statsd com.android.permission com.android.resolv com.android.rkpd com.android.runtime com.android.safetycenter.resources com.android.scheduling com.android.sdkext com.android.support.apexer com.android.telephony com.android.telephonymodules com.android.tethering com.android.tzdata com.android.uwb com.android.uwb.resources com.android.virt com.android.vndk.current com.android.vndk.current.on_vendor com.android.wifi com.android.wifi.dialog com.android.wifi.resources com.google.pixel.camera.hal com.google.pixel.vibrator.hal com.qorvo.uwb; do
        apex_subject="/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=$apex/emailAddress=android@android.com"
        ./development/tools/make_key "$CERT_DIR/$apex" "$apex_subject" -password pass:"$PASSWORD"
        openssl pkcs8 -in "$CERT_DIR/$apex.pk8" -inform DER -out "$CERT_DIR/$apex.pem" -passin pass:"$PASSWORD" -passout pass:"$PASSWORD"
    done

    # Installing B2 if not there
    if ! command -v b2 &> /dev/null; then
        echo "B2 CLI not found, installing..."
        pip install --upgrade b2
    fi
    
    # Just Some space
    echo
    echo
    
    # Read important infos on runtime to  
    read -p "Enter Bucket Name: " BUCKET_NAME
    echo
    read -p "Enter B2 Key Id: " BKEY_ID
    echo
    read -p "Enter B2 App Key: " BAPP_KEY
    echo
    
    # Authenticate B2
    b2 account authorize "$BKEY_ID" "$BAPP_KEY"

    # Upload keys to Backblaze B2
    b2 sync --replace-newer "$CERT_DIR" "b2://$BUCKET_NAME/android-certs"

    echo "Keys have been generated, password protected, and uploaded to Backblaze B2."
fi
