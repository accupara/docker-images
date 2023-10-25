# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:22.04

RUN set -x \
 && sudo apt-get update \
# Install tex, xetex
# Install font-awesome
 && sudo apt-get install -y \
    fonts-firacode \
    fonts-font-awesome \
    inkscape \
    texlive-full \
    texlive-xetex \
    unzip \
    wget \
# Install Fira Sans Font
 && cd /tmp && mkdir dl && cd dl \
# Fonts also available at: https://github.com/bBoxType/FiraSans
 && wget -q "https://bboxtype.com/downloads/Fira/Download_Folder_FiraSans_4301.zip" \
 && wget -q "https://bboxtype.com/downloads/Fira/Fira_Mono_3_2.zip" \
# Unzip the downloaded fonts
 && unzip Download_Folder_FiraSans_4301.zip \
 && unzip Fira_Mono_3_2.zip \
# Create the destination font folders and then copy the contents
 && sudo mkdir -p /usr/share/fonts/truetype/FiraSans \
 && sudo mkdir -p /usr/share/fonts/opentype/FiraSans \
 && sudo cp Download_Folder_FiraSans_4301/Fonts/Fira_Sans_TTF_4301/*/*/*.ttf  /usr/share/fonts/truetype/FiraSans/ \
 && sudo cp Download_Folder_FiraSans_4301/Fonts/Fira_Sans_OTF_4301/*/*/*.otf  /usr/share/fonts/opentype/FiraSans/ \
 && sudo cp Fira_Mono_3_2/Fonts/FiraMono_WEB_32/*.ttf                         /usr/share/fonts/truetype/FiraSans/ \
 && sudo cp Fira_Mono_3_2/Fonts/FiraMono_OTF_32/*.otf                         /usr/share/fonts/truetype/FiraSans/ \
# Cleanup the downloads and unzipped data
 && cd .. && rm -rf dl \
# Update the font cache
 && sudo fc-cache -fv \
# Cleanup the apt cache
 && sudo apt-get clean \
 && sudo rm -f /var/lib/apt/lists/*_dists_*
