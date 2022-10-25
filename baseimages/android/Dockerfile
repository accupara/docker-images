# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:20.04

# 1. Android Studio download page: https://developer.android.com/studio/index.html#downloads
#    "Just get the nd line tools"
# 2. Android NDK Download page: https://developer.android.com/ndk/downloads/index.html
# 3. Update licenses and update from Stackoverflow: https://stackoverflow.com/questions/38096225/automatically-accept-all-sdk-licences

# Version information:
# Build tools: https://developer.android.com/studio/releases/build-tools search "buildToolsVersion"
# NDK: https://github.com/android/ndk/wiki search for "ndkVersion"

# To get a full list of packages that sdkmanager works with: `sdkmanager --list`

# Setting the env variables before hand doesn't hurt at all
ENV SDK_TOOLS_VER=7583922 \
    NDK_TOOLS_VER=24.0.8215888 \
    ANDROID_HOME=/opt/android \
    ANDROID_SDK=/opt/android \
    ANDROID_NDK=/opt/android/ndk/24.0.8215888 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/android/cmdline-tools/latest:/opt/android/cmdline-tools/latest/bin

RUN set -x \
 && sudo apt-get update \
 && sudo apt-get dist-upgrade -y \
 && sudo apt-get install -y \
    libasound2 \
    libc6 \
    libdbus-1-3 \
    libfontconfig1 \
    libgl1-mesa-glx \
    libglu1 \
    libnss3 \
    libpulse-dev \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxi6 \
    libxtst6 \
    maven \
    openjdk-8-jdk \
    wget \
    unzip \
# Prep licenses
 && sudo mkdir -p /opt/android/licenses ~/.android \
 && sudo chown -R admin.admin ~/.android /opt/android/ \
 && touch ~/.android/repositories.cfg \
 && echo 8933bad161af4178b1185d1a37fbf41ea5269c55 >  /opt/android/licenses/android-sdk-license \
 && echo d56f5187479451eabf01fb78af6dfcb131a6481e >> /opt/android/licenses/android-sdk-license \
 && echo 84831b9409646a918e30573bab4c9c91346d8abd >  /opt/android/licenses/android-sdk-preview-license \
# Download the command line tools that have the sdkmanager
 && wget -q https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS_VER}_latest.zip \
 && unzip -d /opt/android/cmdline-tools/ commandlinetools-linux-${SDK_TOOLS_VER}_latest.zip \
 && mv /opt/android/cmdline-tools/cmdline-tools /opt/android/cmdline-tools/latest \
 && rm commandlinetools-linux-${SDK_TOOLS_VER}_latest.zip \
# And now begin installing everything using sdkmanager
 && yes | sdkmanager --licenses \
 && echo "Licenses accepted" \
 && yes | sdkmanager \
 "tools" \
 && echo "Platform tools installed" \
 && yes | sdkmanager \
 "platforms;android-32" \
 "platforms;android-31" \
 && echo "Platforms installed" \
 && yes | sdkmanager \
 "build-tools;32.0.0" \
 "build-tools;31.0.0" \
 && echo "Build tools installed" \
 && yes | sdkmanager \
 "system-images;android-32;google_apis;x86_64" \
 "system-images;android-32;google_apis_playstore;x86_64" \
 "system-images;android-32;google_apis_playstore;arm64-v8a" \
 "system-images;android-31;google-tv;x86" \
 "system-images;android-31;google_apis;x86_64" \
 "system-images;android-31;google_apis_playstore;x86_64" \
 "system-images;android-31;google_apis_playstore;arm64-v8a" \
 "system-images;android-31;google_apis;arm64-v8a" \
 "system-images;android-31;default;x86_64" \
 "system-images;android-31;default;arm64-v8a" \
 "system-images;android-31;android-tv;x86" \
 && echo "System images installed" \
 && yes | sdkmanager \
 "extras;android;m2repository" \
 "extras;google;m2repository" \
 "extras;google;google_play_services" \
 "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
 "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" \
 "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" \
 "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.1" \
 && echo "Extras installed" \
 && yes | sdkmanager \
 "add-ons;addon-google_apis-google-24" \
 "add-ons;addon-google_apis-google-23" \
 "add-ons;addon-google_apis-google-22" \
 "add-ons;addon-google_apis-google-21" \
 && echo "Add-ons installed" \
 && yes | sdkmanager \
 "ndk;${NDK_TOOLS_VER}" \
# There's a LOT of code that depends on this particular version of the NDK... So pre-download it.
 && cd /opt/android/ndk \
 && wget -q https://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip \
 && unzip android-ndk-r12b-linux-x86_64.zip \
 && rm android-ndk-r12b-linux-x86_64.zip
