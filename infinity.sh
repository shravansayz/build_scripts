#!/bin/bash

rm -rf .repo/local_manifests && \
repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b infinity .repo/local_manifests && \
/opt/crave/resync.sh && \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=crave ; \
export TZ=Asia/Kolkata ; \
wget https://github.com/shravansayz/local_manifests/raw/keys/keys.zip && unzip -o keys.zip -d vendor/lineage-priv/ && rm keys.zip && \
source build/envsetup.sh && \
lunch infinity_RMX1901-user && \
make installclean ; \
m bacon
