# Copyright (c) 2016-2017 Accupara Inc. All rights reserved
FROM accupara/ubuntu:17.04
MAINTAINER Accupara Inc. "contact@accupara.com"

RUN sudo apt-get update

# Links information
# 1. Android Studio download page: https://developer.android.com/studio/index.html#downloads
#    "Just get the nd line tools"
# 2. Android NDK Download page: https://developer.android.com/ndk/downloads/index.html
RUN sudo apt-get install -y \
    libdbus-1-3 \
    libfontconfig1 \
    libgl1-mesa-glx \
    libx11-xcb1 \
    openjdk-8-jdk \
    wget \
    unzip \
 && wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
         https://dl.google.com/android/repository/android-ndk-r15b-linux-x86_64.zip \
 && unzip sdk-tools-linux-3859397.zip \
 && unzip android-ndk-r15b-linux-x86_64.zip \
 && rm sdk-tools-linux-3859397.zip android-ndk-r15b-linux-x86_64.zip \
 && sudo mkdir -p /opt/android-tools/licenses \
 && sudo mv android-ndk-r15b tools /opt/android-tools/ \
 && sudo bash -c "echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > /opt/android-tools/licenses/android-sdk-license"

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/android-tools/tools:/opt/android-tools/tools/bin:/opt/android-tools/android-ndk-r15b

RUN sudo bash -c "echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > /opt/android-tools/licenses/android-sdk-license" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platform-tools" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-26" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-25" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-24" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-23" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-21" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-20" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-19" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-17" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-15" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "platforms;android-10" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;26.0.0" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;25.0.3" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;25.0.2" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;24.0.3" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;23.0.3" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;22.0.1" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;21.1.2" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;20.0.0" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;19.1.0" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "build-tools;17.0.0" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-25;google_apis;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-24;default;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-22;default;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-21;default;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-19;default;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-17;default;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "system-images;android-15;default;armeabi-v7a" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "extras;android;m2repository" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "extras;google;m2repository" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "extras;google;google_play_services" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "add-ons;addon-google_apis-google-23" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "add-ons;addon-google_apis-google-22" \
 && sudo /opt/android-tools/tools/bin/sdkmanager "add-ons;addon-google_apis-google-21"
