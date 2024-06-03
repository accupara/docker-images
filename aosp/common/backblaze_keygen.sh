
#!/bin/bash
set -euo pipefail
if [ "${DCDEVSPACE:-0}" == "1" ]; then
    # Create a temporary directory for certificates
    CERT_DIR=$(mktemp -d /tmp/android-certs.XXXXXX)
    # Define the subject details for the certificates
    echo "Enter the following details for your Certificate subject"
    echo
    read -p "Country : " C
    read -p "State : " ST
    read -p "Locality : " L
    read -p "Organization Name : " O
    read -p "Organizaional Unit : " OU
    read -p "Common Name : " CN
    read -p "Email - ID : " MAIL
    SUBJECT="/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN/emailAddress=$MAIL"
    echo
    echo "This is the password which the certificates you generate will use."
    read -sp "Enter the password: " PASS
    echo
    echo "Remember this password, this is the password which is used to encrypt your password. This will be used further used in crave_sign script."
    read -sp "Enter the Encryption Password: " PASS_ENCRYPT
    echo
    if ! printf "$PASS" | openssl enc -aes-256-cbc -iter 256 -salt -out "$CERT_DIR/password.enc" -pass pass:"$PASS_ENCRYPT"; then
        echo "Failed to encrypt the password"
        exit 1
    fi
    # Copy the make_key tool to the temporary directory
    cp ./development/tools/make_key "$CERT_DIR/"
    # Modify the make_key tool to use 4096-bit keys instead of 2048-bit keys
    sed -i 's|2048|4096|g' "$CERT_DIR/make_key"
    # List of certificate names
    CERT_NAMES=("bluetooth" "cyngn-app" "media" "networkstack" "platform" "releasekey" "sdk_sandbox" "shared" "testcert" "testkey" "verity")
    # Loop through each certificate name and generate the keys
    for CERT_NAME in "${CERT_NAMES[@]}"; do 
        echo "Generating key for $CERT_NAME" 
        if printf "$PASS" | "$CERT_DIR"/make_key "$CERT_DIR"/"$CERT_NAME" "$SUBJECT"; then 
            echo "Successfully created key for "$CERT_NAME"
        else
            echo "Failed to create key for "$CERT_NAME"
        exit 1
        fi
    done 
    PACKAGE_NAMES=( "com.android.adbd" "com.android.adservices" "com.android.adservices.api" "com.android.appsearch" "com.android.art" "com.android.bluetooth" "com.android.btservices" "com.android.cellbroadcast" "com.android.compos" 
        "com.android.configinfrastructure" "com.android.connectivity.resources" "com.android.conscrypt" "com.android.devicelock" "com.android.extservices" "com.android.graphics.pdf" "com.android.hardware.biometrics.face.virtual" 
        "com.android.hardware.biometrics.fingerprint.virtual" "com.android.hardware.boot" "com.android.hardware.cas" "com.android.hardware.wifi" "com.android.healthfitness" "com.android.hotspot2.osulogin" "com.android.i18n" "com.android.ipsec" 
        "com.android.media" "com.android.media.swcodec" "com.android.mediaprovider" "com.android.nearby.halfsheet" "com.android.networkstack.tethering" "com.android.neuralnetworks" "com.android.ondevicepersonalization" "com.android.os.statsd" 
        "com.android.permission" "com.android.resolv" "com.android.rkpd" "com.android.runtime" "com.android.safetycenter.resources" "com.android.scheduling" "com.android.sdkext" "com.android.support.apexer" "com.android.telephony" 
        "com.android.telephonymodules" "com.android.tethering" "com.android.tzdata" "com.android.uwb" "com.android.uwb.resources" "com.android.virt" "com.android.vndk.current" "com.android.vndk.current.on_vendor" "com.android.wifi" 
        "com.android.wifi.dialog" "com.android.wifi.resources" "com.google.pixel.camera.hal" "com.google.pixel.vibrator.hal" "com.qorvo.uwb"
    )
    # Loop through each package name and generate keys, then convert to PEM format
    for PACKAGE_NAME in "${PACKAGE_NAMES[@]}"; do 
        echo "Generating key for $PACKAGE_NAME"    
        # Generate the key
    if printf "$PASS" | "$CERT_DIR"/make_key "$CERT_DIR"/"$PACKAGE_NAME" "$SUBJECT"; then 
        echo "Successfully created key for "$PACKAGE_NAME"
        # Convert the key to PEM format
        if printf "$PASS" | openssl pkcs8 -in "$CERT_DIR"/"$PACKAGE_NAME".pk8 -inform DER -out "$CERT_DIR"/"$PACKAGE_NAME".pem; then 
            echo "Successfully converted "$PACKAGE_NAME" key to PEM format" 
        else 
            echo "Failed to convert "$PACKAGE_NAME" key to PEM  format" 
            exit 0
        fi
    else 
        echo "Failed to create key for "$PACKAGE_NAME" 
        exit 0
    fi 
    done
    echo "All keys generated and converted to PEM format successfully."
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
    if ! b2 account authorize "$BKEY_ID" "$BAPP_KEY"; then
        echo "B2 authorization failed."
    fi

    # Upload keys to Backblaze B2
    if ! b2 sync --replace-newer "$CERT_DIR" "b2://$BUCKET_NAME/android-certs"; then
        echo "Failed to upload keys to Backblaze B2"
    fi

    echo "Keys have been generated, password protected, and uploaded to Backblaze B2."
    echo "Cleaning up..."
    echo "Clearing ENV Variables"
    echo "Clearing Certificates from Devspace"
    rm -rf "$CERT_DIR"
    echo "Cleared Certificates from Devspace"
    unset BUCKET_NAME
    unset BKEY_ID
    unset BAPP_KEY
    unset PASS_ENCRYPT
    unset PASSWORD
    unset C
    unset ST
    unset L
    unset O
    unset OU
    unset CN
    unset MAIL
    echo "Cleared ENV Variables"
    b2 account clear
    echo "Cleared B2 Account"
fi
