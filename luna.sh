#!/bin/bash

rm -rf .repo/local_manifests && \
repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs && \
git clone https://github.com/shravansayz/local_manifests.git --depth 1 -b luna16 .repo/local_manifests && \
/opt/crave/resync.sh && \
export BUILD_USERNAME=shravan ; \
export BUILD_HOSTNAME=crave ; \
export TZ=Asia/Kolkata ; \
wget https://github.com/shravansayz/local_manifests/raw/keys/keys.zip && unzip -o keys.zip -d vendor/lineage-priv/ && rm keys.zip && \
source build/envsetup.sh && \
lunch lineage_RMX1901-bp2a-user && \
make installclean ; \
m lunaris
