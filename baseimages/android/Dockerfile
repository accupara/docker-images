# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:17.04
MAINTAINER Accupara Inc. "contact@accupara.com"

RUN sudo apt-get update

# 1. Android Studio download page: https://developer.android.com/studio/index.html#downloads
#    "Just get the nd line tools"
# 2. Android NDK Download page: https://developer.android.com/ndk/downloads/index.html
# 3. Update licenses and update from Stackoverflow: https://stackoverflow.com/questions/38096225/automatically-accept-all-sdk-licences
RUN sudo apt-get install -y \
    libdbus-1-3 \
    libfontconfig1 \
    libgl1-mesa-glx \
    libx11-xcb1 \
    openjdk-8-jdk \
    wget \
    unzip \
 && sudo mkdir -p /opt/android-tools/licenses ~/.android \
 && sudo chown -R admin.admin ~/.android /opt/android-tools/ \
 && touch ~/.android/repositories.cfg \
 && echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > /opt/android-tools/licenses/android-sdk-license \
 && echo d56f5187479451eabf01fb78af6dfcb131a6481e > /opt/android-tools/licenses/android-sdk-license \
 && echo 84831b9409646a918e30573bab4c9c91346d8abd > /opt/android-tools/licenses/android-sdk-preview-license \
 && wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
         https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip \
 && unzip sdk-tools-linux-3859397.zip \
 && unzip android-ndk-r14b-linux-x86_64.zip \
 && rm sdk-tools-linux-3859397.zip android-ndk-r14b-linux-x86_64.zip \
 && mv android-ndk-r14b tools /opt/android-tools/

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/android-tools/tools:/opt/android-tools/tools/bin:/opt/android-tools/android-ndk-r14b \
    ANDROID_HOME=/opt/android-tools

RUN sdkmanager "platform-tools" \
 && sdkmanager "platforms;android-26" \
 && sdkmanager "platforms;android-25" \
 && sdkmanager "platforms;android-24" \
 && sdkmanager "platforms;android-23" \
 && sdkmanager "platforms;android-21" \
 && sdkmanager "platforms;android-20" \
 && sdkmanager "platforms;android-19" \
 && sdkmanager "platforms;android-17" \
 && sdkmanager "platforms;android-15" \
 && sdkmanager "platforms;android-10" \
 && echo "Platforms installed" \
 && sdkmanager "build-tools;26.0.0" \
 && sdkmanager "build-tools;25.0.3" \
 && sdkmanager "build-tools;25.0.2" \
 && sdkmanager "build-tools;24.0.3" \
 && sdkmanager "build-tools;23.0.3" \
 && sdkmanager "build-tools;22.0.1" \
 && sdkmanager "build-tools;21.1.2" \
 && sdkmanager "build-tools;20.0.0" \
 && sdkmanager "build-tools;19.1.0" \
 && sdkmanager "build-tools;17.0.0" \
 && echo "Build tools installed" \
 && sdkmanager "system-images;android-25;google_apis;armeabi-v7a" \
 && sdkmanager "system-images;android-24;default;armeabi-v7a" \
 && sdkmanager "system-images;android-22;default;armeabi-v7a" \
 && sdkmanager "system-images;android-21;default;armeabi-v7a" \
 && sdkmanager "system-images;android-19;default;armeabi-v7a" \
 && sdkmanager "system-images;android-17;default;armeabi-v7a" \
 && sdkmanager "system-images;android-15;default;armeabi-v7a" \
 && echo "System images installed" \
 && sdkmanager "extras;android;m2repository" \
 && sdkmanager "extras;google;m2repository" \
 && sdkmanager "extras;google;google_play_services" \
 && sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
 && sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" \
 && echo "Extras installed" \
 && sdkmanager "add-ons;addon-google_apis-google-23" \
 && sdkmanager "add-ons;addon-google_apis-google-22" \
 && sdkmanager "add-ons;addon-google_apis-google-21" \
 && echo "Add-ons installed"
